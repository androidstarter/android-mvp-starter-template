package ${packageName}.data;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.inject.Singleton;

import ${packageName}.data.model.NamedResource;
import ${packageName}.data.model.Pokemon;
import ${packageName}.data.model.PokemonListResponse;
import ${packageName}.data.remote.MvpStarterService;
import rx.Single;
import rx.functions.Func1;

@Singleton
public class DataManager {

    private final MvpStarterService mMvpStarterService;

    @Inject
    public DataManager(MvpStarterService mvpStarterService) {
        mMvpStarterService = mvpStarterService;
    }

    public Single<List<String>> getPokemonList(int limit) {
        return mMvpStarterService.getPokemonList(limit)
                .flatMap(new Func1<PokemonListResponse, Single<List<String>>>() {
                    @Override
                    public Single<List<String>> call(PokemonListResponse pokemonListResponse) {
                        List<String> pokemonNames = new ArrayList<>();
                        for (NamedResource pokemon : pokemonListResponse.results) {
                            pokemonNames.add(pokemon.name);
                        }
                        return Single.just(pokemonNames);
                    }
                });
    }

    public Single<Pokemon> getPokemon(String name) {
        return mMvpStarterService.getPokemon(name);
    }

}