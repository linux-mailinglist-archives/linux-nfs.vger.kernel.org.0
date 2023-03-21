Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECEF6C3136
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 13:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCUMGI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 08:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCUMGH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 08:06:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B7F206A0
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 05:06:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECB1AB8164F
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 12:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CACC433D2;
        Tue, 21 Mar 2023 12:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679400362;
        bh=1HNJuQ+50PTWIN/cjCol5Kr1/ueU/yx5BYodKCIvPQs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TmQQfGTreh4WR+9rr8kojSadh88SbVqBSthgwoh2Yx2CibcOkt+Py2cdnJ47EF43R
         Vhl8cuL1aSW8K97UIecbWwesYSCA0H8U06S0R2nL1fOP3Z5s4f3+0ZxSadujE8aznM
         WERh83xbuW7xYlAIKl0mE3tOyzrvz14pTj9hLgQTCynbemsED9WVbXexgJow4qtJ87
         BU2IBfdkPGxbTk6ZZLIQfe9hp7ARCWajtfi7/Nn22Ix/iE5GikWbB7ANoecl3oTGQM
         kjohgVQbaeCveCdBsmrftBqPfA6FPhvukqdUD2RUOAXgObDyKxC8blbF72Uxkw/oDC
         utwWMPfncxGuw==
Message-ID: <fdfa374a7d5072c9b4606476b52f049a6a165ef9.camel@kernel.org>
Subject: Re: [PATCH v1 4/4] exports.man: Add description of xprtsec= to
 exports(5)
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 21 Mar 2023 08:06:00 -0400
In-Reply-To: <167932295124.3437.894267501240103990.stgit@manet.1015granger.net>
References: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
         <167932295124.3437.894267501240103990.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-03-20 at 10:35 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  utils/exportfs/exports.man |   45 ++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
>=20
> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> index 54b3f8776ea6..cca9bb7b4aeb 100644
> --- a/utils/exportfs/exports.man
> +++ b/utils/exportfs/exports.man
> @@ -125,7 +125,49 @@ In that case you may include multiple sec=3D options=
, and following options
>  will be enforced only for access using flavors listed in the immediately
>  preceding sec=3D option.  The only options that are permitted to vary in
>  this way are ro, rw, no_root_squash, root_squash, and all_squash.
> +.SS Transport layer security
> +The Linux NFS server supports the use of transport layer security to
> +protect RPC traffic between itself and its clients.
> +This can be in the form of a VPN, an ssh tunnel, or via RPC-with-TLS,
> +which uses TLSv1.3.

This is a little awkward, as the NFS server really isn't involved at all
at that level in the case of a VPN or ssh tunnel. How about:

The Linux NFS server supports transport layer security (TLS) to protect
RPC traffic between itself and its clients via RPC-with-TLS which uses
TLSv1.3. Alternately, RPC traffic can be secured via a VPN, ssh tunnel
or similar mechanism that encrypts traffic in a way that is transparent
to the server.

>  .PP
> +Administrators may choose to require the use of
> +RPC-with-TLS to protect access to individual exports.
> +This is particularly useful when using non-cryptographic security
> +flavors such as
> +.IR sec=3Dsys .
> +The
> +.I xprtsec=3D
> +option, followed by a colon-delimited list of security policies,
> +can restrict access to the export to only clients that have negotiated
> +transport-layer security.
> +Currently supported transport layer security policies include:
> +.TP
> +.IR none
> +The server permits clients to access the export
> +without the use of transport layer security.
> +.TP
> +.IR tls
> +The server permits clients that have negotiated an RPC-with-TLS session
> +without peer authentication (confidentiality only) to access the export.
> +Clients are not required to offer an x.509 certificate
> +when establishing a transport layer security session.
> +.TP
> +.IR mtls
> +The server permits clients that have negotiated an RPC-with-TLS session
> +with peer authentication to access the export.
> +The server requires clients to offer an x.509 certificate
> +when establishing a transport layer security session.
> +.PP
> +The default setting is
> +.IR xprtsec=3Dnone:tls:mtls .

Shouldn't that list order be reversed? IOW, shouldn't we default to mtls
first since it's more secure?

It might also be good to spell out what the kernel does with an ordered
list here. In what order are these methods attempted and at what point
does the server give up?


> +This is also known as "opportunistic mode".
> +The server permits clients to use any transport layer security mechanism
> +to access the export.
> +.PP
> +The server administrator must install and configure
> +.BR tlshd
> +to handle transport layer security handshake requests from the local ker=
nel.

In the event that tlshd isn't running, what happens? I assume we give up
on TLS at that point, but how long does it take for the kernel to
realize that it's not there?

>  .SS General Options
>  .BR exportfs
>  understands the following export options:
> @@ -581,7 +623,8 @@ a character class wildcard match.
>  .BR netgroup (5),
>  .BR mountd (8),
>  .BR nfsd (8),
> -.BR showmount (8).
> +.BR showmount (8),
> +.BR tlshd (8).
>  .\".SH DIAGNOSTICS
>  .\"An error parsing the file is reported using syslogd(8) as level NOTIC=
E from
>  .\"a DAEMON whenever
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
