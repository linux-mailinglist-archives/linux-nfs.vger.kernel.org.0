Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2237EEB3D
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 03:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjKQCxd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 21:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQCxc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 21:53:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1147F1AD;
        Thu, 16 Nov 2023 18:53:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2C52120509;
        Fri, 17 Nov 2023 02:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700189607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NB0T88Bz1NkBEV9ckcMVtoKdeQngpB+JyIHTJiYvV70=;
        b=jHAdBLIRbfzQq8Gmlqm/J6T+Mauv7ot6uVBlU/wWNcDnrxV6j0H3firPzLMPvXbQ//jmN3
        MxQoa0Hf2+o+lxlaWWNCSs8JpifnxjF7kmUfEqEuJevtxOrXJW5riSSe5AVN+Mm2RehFxW
        dKwR3OCllt5mjtQ6JkBqIo99Fs3gYAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700189607;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NB0T88Bz1NkBEV9ckcMVtoKdeQngpB+JyIHTJiYvV70=;
        b=2AKk8dTdSP/fjn1Wn9gMYObr7YOoz30ARm724J07GUv2q0qWecZOtfdANO+DYYQKWxudNa
        aMQmjZ2R1zWo8tCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C87F61341F;
        Fri, 17 Nov 2023 02:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id blGFGZ/VVmWSHwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 17 Nov 2023 02:53:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Kees Cook" <keescook@chromium.org>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Anna Schumaker" <anna@kernel.org>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, "Azeem Shaikh" <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Replace strlcpy() with strscpy()
In-reply-to: <20231114175407.work.410-kees@kernel.org>
References: <20231114175407.work.410-kees@kernel.org>
Date:   Fri, 17 Nov 2023 13:53:15 +1100
Message-id: <170018959595.19300.7615621918111285329@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[18];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[hammerspace.com,chromium.org,kernel.org,oracle.com,netapp.com,talpey.com,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 15 Nov 2023, Kees Cook wrote:
> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead
> to linear read overflows if a source string is not NUL-terminated[1].
> Additionally, it returns the size of the source string, not the
> resulting size of the destination string. In an effort to remove strlcpy()
> completely[2], replace strlcpy() here with strscpy().
>=20
> Explicitly handle the truncation case by returning the size of the
> resulting string.
>=20
> If "nodename" was ever longer than sizeof(clnt->cl_nodename) - 1, this
> change will fix a bug where clnt->cl_nodelen would end up thinking there
> were more characters in clnt->cl_nodename than there actually were,
> which might have lead to kernel memory content exposures.
>=20
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna@kernel.org>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Neil Brown <neilb@suse.de>
> Cc: Olga Kornievskaia <kolga@netapp.com>
> Cc: Dai Ngo <Dai.Ngo@oracle.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-nfs@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y [1]
> Link: https://github.com/KSPP/linux/issues/89 [2]
> Co-developed-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  net/sunrpc/clnt.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index daa9582ec861..7afe02bdea4a 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -287,8 +287,14 @@ static struct rpc_xprt *rpc_clnt_set_transport(struct =
rpc_clnt *clnt,
> =20
>  static void rpc_clnt_set_nodename(struct rpc_clnt *clnt, const char *noden=
ame)
>  {
> -	clnt->cl_nodelen =3D strlcpy(clnt->cl_nodename,
> -			nodename, sizeof(clnt->cl_nodename));
> +	ssize_t copied;
> +
> +	copied =3D strscpy(clnt->cl_nodename,
> +			 nodename, sizeof(clnt->cl_nodename));
> +
> +	clnt->cl_nodelen =3D copied < 0
> +				? sizeof(clnt->cl_nodename) - 1
> +				: copied;
>  }

Reviewed-by: NeilBrown <neilb@suse.de>

If it were "copied =3D=3D -E2BIG" instead of "copied < 0" it would be more
obvious why sizeof(...) is used in that case.
But we really want to do something sensible for *any* error message that
might be added in the future.. I guess.

Thanks,
NeilBrown


> =20
>  static int rpc_client_register(struct rpc_clnt *clnt,
> --=20
> 2.34.1
>=20
>=20

