Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46B97EF4D3
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 15:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjKQO5z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 09:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQO5y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 09:57:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7F09F
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 06:57:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96F0C433C8;
        Fri, 17 Nov 2023 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700233071;
        bh=A2KCUogVaFj7qh0J15xpenR08lZq5BlJ2VzIICBy8YQ=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=dRklqTLzwYrS1SJl0eZgO0jt7o/HxHhfHhkdxeQFGTer8ooT22SrxHkP4JUeX7dgb
         yjFOPJT94rhVuEdxwK1UEpcWxFxHzijJFB3ijacQ00nelYQMcB4HV9K+EwODGMH1hM
         lD7TQCwODdyVOmccJUuCkRxKIKl3W3a13iqWFi5P1KDJRCFrwgZEChOQX8tLl10DgU
         b8XEwmTHFuEe++lA8TXCEAUH1mrlDcTnK9OeEhjOCnHWmkZuThEjjDPPZ86Tokf0K7
         MBY7ZOGtrRtZ2nfwMCEctfK2jDLV3zxrht0s6eWZLlOq7W44JLvOeD4hUnLvdFdCmg
         qirTm+W6nmZQw==
Message-ID: <ec54d81630f78c764c930a50b4ba75b26e4b8ff0.camel@kernel.org>
Subject: Re: [PATCH v2 1/3] NFSD: Fix "start of NFS reply" pointer passed to
 nfsd_cache_update()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Date:   Fri, 17 Nov 2023 09:57:49 -0500
In-Reply-To: <169963371324.5404.3057239228897633466.stgit@bazille.1015granger.net>
References: <169963305585.5404.9796036538735192053.stgit@bazille.1015granger.net>
         <169963371324.5404.3057239228897633466.stgit@bazille.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
        kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: multipart/mixed; boundary="=-PLs1yDriMiwmGdYLvVdB"
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-PLs1yDriMiwmGdYLvVdB
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

On Fri, 2023-11-10 at 11:28 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> The "statp + 1" pointer that is passed to nfsd_cache_update() is
> supposed to point to the start of the egress NFS Reply header. In
> fact, it does point there for AUTH_SYS and RPCSEC_GSS_KRB5 requests.
>=20
> But both krb5i and krb5p add fields between the RPC header's
> accept_stat field and the start of the NFS Reply header. In those
> cases, "statp + 1" points at the extra fields instead of the Reply.
> The result is that nfsd_cache_update() caches what looks to the
> client like garbage.
>=20
> A connection break can occur for a number of reasons, but the most
> common reason when using krb5i/p is a GSS sequence number window
> underrun. When an underrun is detected, the server is obliged to
> drop the RPC and the connection to force a retransmit with a fresh
> GSS sequence number. The client presents the same XID, it hits in
> the server's DRC, and the server returns the garbage cache entry.
>=20
> The "statp + 1" argument has been used since the oldest changeset
> in the kernel history repo, so it has been in nfsd_dispatch()
> literally since before history began. The problem arose only when
> the server-side GSS implementation was added twenty years ago.
>=20
> This particular patch applies cleanly to v6.5 and later, but needs
> some context adjustment to apply to earlier kernels. Before v5.16,
> nfsd_dispatch() does not use xdr_stream, so saving the NFS header
> pointer before calling ->pc_encode is still an appropriate fix
> but it needs to be implemented differently.
>=20
> Cc: <stable@vger.kernel.org> # v5.16+
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfssvc.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index d6122bb2d167..60aacca2bca6 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -981,6 +981,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	const struct svc_procedure *proc =3D rqstp->rq_procinfo;
>  	__be32 *statp =3D rqstp->rq_accept_statp;
>  	struct nfsd_cacherep *rp;
> +	__be32 *nfs_reply;
> =20
>  	/*
>  	 * Give the xdr decoder a chance to change this if it wants
> @@ -1014,6 +1015,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	if (test_bit(RQ_DROPME, &rqstp->rq_flags))
>  		goto out_update_drop;
> =20
> +	nfs_reply =3D xdr_inline_decode(&rqstp->rq_res_stream, 0);
>  	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
>  		goto out_encode_err;
> =20
> @@ -1023,7 +1025,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	 */
>  	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter +=
 1);
> =20
> -	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
> +	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, nfs_reply);
>  out_cached_reply:
>  	return 1;
> =20
>=20
>=20

With this patch, I'm seeing a regression in pynfs RPLY14. In the
attached capture the client sends a replay of an earlier call, and the
server responds (frame #97) with a reply that is truncated just after
the RPC accept state.
--=20
Jeff Layton <jlayton@kernel.org>

--=-PLs1yDriMiwmGdYLvVdB
Content-Type: application/vnd.tcpdump.pcap; name="RPLY14.pcap.gz"
Content-Disposition: attachment; filename="RPLY14.pcap.gz"
Content-Transfer-Encoding: base64

H4sICHRxV2UAA1JQTFkxNC5wY2FwAN1dC3RUxRmefcVklchLHkowBIgE2BByFZW2p3IUjiLuUapI
Ww6YwkYCeZEE5BkGBMQHtrTrAy2IFC3yUlOlShUhgPK8IYAREbSiFY/HHsVjrU/o/9+Ze7M7O7tM
koldDOy5u3tn7v9/3/f/M3Pn3rl7eHvNk27iJc6fmxAXbK6fcnto6zwPGQvvx5Lov0XH70jfPpz0
SblG2OESP2+7NdVlmBO24YeV7vmE5IEB75kdXneqv21Nv3KrkMdzHlr7KL61tH/9XcVaKtgLhrfs
A4u1K9vHWJuCFm1r34C1UVBplBxbpjK2WrC4n7Z1eUkf+NLlWJqCVj6/Ny4m3zdVSgyOTnXVuzce
i8NgZSSD7vviWvOuX67I4OgBv3KbYPG4hMFKfNnWOt0Xl0HEpsIgw3YcLNYJDFqW0Mq8ZzzkKBQ+
GmsFdVrdRJ26gJX1jpVZqBMlhEbUcxPXor/A1su/w1cm33fB5AmhaWXllYHSwsoJRP7XJVQ6raii
rLQkVFqVWz5j8LiSgsmhqopQyDk+lIHXhfBKCU0vL6uoYtn2yDNx+cT4V+CTx/9+wwwNAz49EXwi
0lloZdA6D3kaCj8tt1LeRCvI5/RoK0DmiAjumsqRzQ/hHFnczFqnJ1tDw4Lh1zKEWHO46fesh3wL
hb+VW9nRRCvIzT7HymzOzUqOkZDWjzUPkcQa/9wp8viB8hmwCVyem8f4vvE5D9kIhTbGMoFRMl01
Sl7LADY+sZigUUzMho+3ciaaEyU2MhuNs0Xv3/qbh6TAUVOEI3MdDyjr+AkgmGp5f8Txfg73fj33
gpDW19FLmqEj3++pKim3WDn0godsgi82Cca5plRZ06mGWfiYxcpih5VqZAZYGcNZaY6mNkrb85gt
osh9SY+2hY8BkjcFbRFFNWXa2kOiZNbWi8dBVv77kiZt3zTMO4cL2s7lrIyJYKGpSJW0ffQVD/HD
0f1ybQ+ranvn8GB46xUWimMOCopIAMVzUM7Hy7e2tj7SQm1h60dmgq96yAn4cEJwgOu7XlXfrVcA
O6ctZl6IYoYCM4u5x83R10Zqey/b+vk200VS5o3p/v7bu++84aGVD1V8sO6K4TXUGoQRMjflZDki
nrrNQ9LBk3R5LBxRjoXTgHqbhfifDuJ5HDFwQFJ4+R9j3NdJBT1sLo49fFv+YpkyfIeHrAAPV8Sy
A/HgmqgcD9sMc+ImZMdV7rAzHxmixHUdZ6e5o7hOvJyIxj5eOrw8E4oqRP/s9+3QfmXZeDhoDAb7
fQd4eQuLCsvi7L8I9xcXlU6Osx9j1ve7YjAS/X3ke/TfO35iQYV8vzWYAx+KQ0TCM6p1YJeHZMGe
LHksf6oayxM3BcO1aVYsf+modTcqRgnZBeXOI7ZLrT+uVI1lawzCVc6S2HJHbMFf17+RsasOeshm
+GKzUJi3dwtU47s2zTCL5luMPeAwthBZAx/v4Iw1d/xpx7fdvtnoHESIpOZNPecURfMBTYlwTrEI
0VB2TpHqWE+edqwb4dojEzOPadK0xDAnZQuaLkY2KNM0VVJXBV1km9VN8MFuwy5BJGfe85Bs2JMt
z+fPVTWdlA1o6i0kXztI7kU0gARUJmm8fLLlc2SrrJzTwz7UpH89MPeVoP99yBxl+qdJ6qowoZzT
KR97yGn4cDoWCeq/S1n/r4Lh7WycesBBcj+iASSrSeOIKdly2tEf2cj7VI+u22FsOnmFoOsDyAhl
uvoldVUQJsrrS+zvrfmfU3r66ckrAM0yoZ9egmgo66fP5+WTLa/tkZRyTj/9H03aLzPM4kmC9g8i
a5Rpf76krgoLyjl9yzd6+uniSYDmB6Gf/j2ioayfvsCxnlw5bWmPTEz6QZOmPxhmSbqg6R+QDco0
vUBSVwVdony2P2cgktlur5Z8LkkPhncUCPm8FNFQls9tePmky2d+5qOczyUerxbtdxQAa0cF7f+I
rFGmfRtJXRUWlPP52jSvlnwuOQpodgr5/CdEQ1k+pzvWkyyfUXtk4tQFmjTdaZil1YKmYWSDMk3T
JXVV0CXK5wy+7Y5Ienbwahl3l1YHwztzhHH3w4iGsnG3HVnJls+RMxXKOb26sx79d+YYZllQ0P8R
ZI4y/S+U1FVhQjmnO2d4tYy7y4KAZokw7n4U0VA27m7rWE+unHb0RzaW9tKk6xJgRDyfegwZoUzX
tpK6KggT5XV3vr0UkRT11dNPl8H51M5TQj/9Z0RDWT/djpdPtry2ZxeVc/rhAZq0P2WY5bWC9suR
Ncq0byepq8KCck7PuUJPP11eGwy/fpvQTz+BaCjrp9s71pMrpy3tkYkFV+vR9PXbDHNKoaDpSmSD
Mk3bS+qqoEuUz5fybSYiaTtUTz5PKQQ0Lwv5vArRUJbPHXj5pMtnfjVAOZ8/uEGT9i8bZkW+oP1q
ZI0y7TtI6qqwoJzPnlF68rkiPxh+Q7yH5q+IhrJ87uhYT7J8Ru2RibLf6NH0jQxgo0HQdA2yQZmm
HSV1VdAlymebwR6IJLXQS/rCnr7yfP5SWdMGQDPPQvK9g2QdogEkMBKzrtYRcm5cl0/hDNrXtqR5
faLYS96FL94VHOQxsEY5BuYZZuVai7nnHOY2IHvA3ALOXHNiQOW6vX2F3D5+D77NIkLuD5rmJblQ
KlceJ1+rxknl2mB4l3Wd0xKfoX0WEQPaw6Qxas+VOLFeEddMpLEyguqJlV1phlk1X4iVGmSQsljp
JKmrwkhzYsXuI3oSIVZeuVdPm1I1HxAvFdqUFxAxZW1KZ9vqORIreEXanoeXxknvpZriZKlhTh0l
xMkmZI+yOOksqavCRnPipCff9iJCnOQt85JBUGqQNE6gTz4rWhYnU0cFw7u7Wm1KqoP2JUQMaI9F
eHyuxAkeJ3VAqGr8gNEDB5LGuV5pzGxdqSdmdnc1zGmDhJjZjExSFjNdJHVVmGlOzPTi295EiJng
03piZtogQPykEDP/QMSUxUxX2+o5EjP2nbnIVuRcojRmvBs0xcyThnlXJyFmXkUmKYuZrpK6Ksw0
J2Z68202EWJmSo2X5EOpfHl/9L1qzNzVKRjeY80tu7wO2tcQMaA9QhrvJDlXYsb2z4oNPk8ljZfH
X9YTL3tygMUvhHjZiixSFi8XS+qqsNKceMnm28uIEC/Lt3i13Id+1xeA+HnhPvRaREzZfej2HQqt
HS94vJ5D3r7t2Mj0mTvhfdvxxUVQdOC48qIJA6+8fNCV15C8qwmuJxhvLds7Py/X+WcdAFmp3urV
sm5kz/OGOX2VsG4EWamlbN3IJZK6KkgtlFho6zho4YZce5V13/mg3e9ZY40dXi1rzaavCob3pglr
zbZz7+G/c7b9Y2jaS4a0404vWQE7V8QiRZ2U7x/eC+caM9i9eOVRSLcDzOs40ubqZPXv6O1ne7xk
FHwzSt6fK6/+mpENHt9itc2Nq792cm/h7MG52tjaumAr09K22Z7PttYg2RrD21SBRbvtJqSxvV7N
P9vzlNYag+mH487aYkwozNrymLjFMGdmC7O2byDTlM3aZkjqqjBns2YzIdvarLhsRlzRvl7Gt31I
4wwOidgmXKOwiM/2dfzi2EhkrOFtPX3ATIjLfRlCH7AbWaOsD7Cvlv1f5zoj0RM+6yiybK3V/M6r
ZS3SvgxgpkFYi1SPzFC2Fqm7pK4K0sh5T2cWORIJolhyRs9c1swGQDJHmMs6iEgom8uyr5wkk7bZ
IiMRf3icS26dWFSZCf+rJoYysQ3JrApVVmVOKKgqyLXYeyjNpycG5hjmrI1CDLyJDFIWA5dK6qow
EhkD9hgPxxTuHttfHJuzpOYkoshI92nJ71kbAclxIb8bEAll+Z3pcJs8MeDl5WMy48oLNWl73DBn
jxW0RVYaKNM2U1JXBWmktoiCnIG/yMqIYkZ7H3HD0d1ybfepajt7bDC8/xcWisMOirc4ijWkcba8
pdp2EBAXlRZV2fvwmC1eH1zQwUdq4IsawTDXdbaqrvt/YZhz/BYjC6IYeQsYGc0ZiaerDKXy+tEJ
nfXk6xw/oFgm5OsRjgDztfHKZ+tp2pLzd0tTwsd1j3TxaTkv378MmNksnJe/jcxQdl6eJambCKmW
daN3853uXXWFiPaJ7j4ta4jnbA6GzR7CGuKjiJiyNcT2jHVrxkDC9joSOVFYM1qdqSe/zR6GWV0q
5Pc7yA5l+d1TUjcR2rOtF7VsW0+l6OEjq+DDqlgEqG2xqrbVpYDCGpORqigE7wCC60njzHKktvbx
Mvn7s2qLHp8Ej3HCrCLWY+T858qcwziomuXedTEed+Eex3COHrh6auIM82FZAs7smdUWc7a+pybO
oL2am5KAs96SupYH3n4+LXPBc1PAixeFueDj3AOcC7ZHni1tQ7pWVo0bXxEqqApZYyEcjPPPjWV0
9Cf2GfN5N9143Q0jAwMJiTMXvDnfp+V5BeaLwOIJ4XkF7yGLlD2vIFtSV4WVLqRZ88FufsXHfXEk
civPrtIUMyeC4bohQsy8j6gpixl7BuMnFzOPX+0jtfBFreAoj5kHVGOmbohh0i1WzISjGHwfGJzI
GZTFTLuErORGMWKjlG0RcTtEtGWwnraXbgFUG4S210aEbW8fXr7Fbe/wn+lpe+s2GOY8v9D2nuAe
d+EeS9veh6/RM36bB2P4ut3C+O0D9IKy8VsOL9/SPOoGEVIRKi8umIERgwFz0+QJRRUjra8ifGzx
tZXvhugZv9XtBna2COM3ZOYDysZvOZK6qmil11ce41cdnhoa90wEtVU4E+HaQj4c6C2ciXzIEeCZ
SF9e/sfStpcM7ewb42Y/6qWQ/UyvA70Nc/4wIfs/QsSUZX9fSV1VBFHXWbJu85Hu8E13ee59rKrP
/GHg9RTL488djz9Gr8HjHVCuHy/fUn06RqHjb/k+nX1X6sibR/x64OWs87LZ+na8jzTA+wbBKa7v
SmV9pxjm3Wyd7BqHrU+RMWBrNmcrnr7xGGjO2Iafd7mda6uIcrAnRcuTF+9OB6Snop+82P8iRIpW
fpvi1xJ53EpU5AW6oRX6E4q8R8/za+mlD5wCxhqie2lkK9CNMgTSyLOeJQgeaImKhmC4vk10VDAP
rPaov1/L+IlbiWpBA705TmxB+/PyLR4/1fXXo0x9G8NckCUogx73pkyZ/pK6lgdFAT2cLcgCL3IE
zrK5B8hZgJdvMWf7A5o4ywGvSwXO0ONsyjgLSOpaHtyf79cy5lxQCl4MjR5zBi7jHuCYM5eXb2nr
c5Ewi1ZYVFpUObFxv7a54+WGX8t5fP1Qw1yYFX0ebzFzGWXn8bmSumdD6yOtMH+cfrVfy3MHF2L+
1Ec/dzCQwxHjcwcH2IZbORa0ziE/ONgfbwU2xoPCCmweD/XA0NHoFdgWOzmUrcAeIKmbGDGMaUni
eWT7eBgXkbMRrtgy1gRFZN8bg8Naw/BLv5bnESw8GgwfnBH9PIJAX84GPo8gj9hutW6sJFznKMSK
yKLyWsc+w/xa1sUdnGGYi9ZGr4sL9EfmKFsXlyepezYmfKQJax0vvTFuNjTpeQSL1gKa40I2BBAN
Zdlgj/6Sqa3AO/sc/a1e9GZNuh43zHtGCroOQEYo01WWj4kRxrYNwnpHN//stp4bdPutevL6npHB
8KEhQl7nIRrK8jqfl0+2vI5s+ZTz+rPRevQ/NMQwF2cJ+g9E5ijTP19S92xMNCmvJ43Rk9eLYQxw
6Ckhr/MRDWV5bTjWkyuvHf2t+0IKNOn6FDCyR9DVQEYo09WQ1E2M8Ox5ze/odVvPD/pkW9yz1ub8
Ykm7qLPWEW35L5YcqY1rBX+FRe13PPBXWOrA0ruxVgIj0Mo12/WcgS/eEwwfTpNYMdDK6PhWmsbY
u4DngHCe72BZE99Kk3755HAa4Nkbj7GTuhjbC5b8Miz/A1RkKDhMaQAA


--=-PLs1yDriMiwmGdYLvVdB--
