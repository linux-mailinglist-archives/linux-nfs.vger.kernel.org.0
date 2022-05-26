Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CCA5358C0
	for <lists+linux-nfs@lfdr.de>; Fri, 27 May 2022 07:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbiE0F1Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 May 2022 01:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiE0F1X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 May 2022 01:27:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50712EBAA5
        for <linux-nfs@vger.kernel.org>; Thu, 26 May 2022 22:27:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 10994218BB;
        Fri, 27 May 2022 05:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653629239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l7nvUxWskKqe83LrWZMRTiXsm3Jvb9juc0cy4Z//C2Y=;
        b=iMZeQLVyPoUUQiykUndM+fs7XqJUpf/Wr48MoXxiCmgVOOFTA+Vkr+FIc+cPfj2XqfkD6c
        sWp5hHMDkaTKxkppit7NkgIYAnQBZErqX5r/PqEYbSuYH0qxhRU49+LC1I2jWmMqdCT21g
        aV5vijzvuXKcxh9iT5OgFr4vUup59q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653629239;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l7nvUxWskKqe83LrWZMRTiXsm3Jvb9juc0cy4Z//C2Y=;
        b=pMVwpt7ssxpVSGi3GRzFTw/w56gWiirau/xOGmYbGM9YjXzMRbT9s8LAn78elewVszwbsg
        JzNSSfltdi5UBXCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 364581346B;
        Fri, 27 May 2022 05:27:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GTuXODVhkGIeewAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 27 May 2022 05:27:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Steve Dickson" <steved@redhat.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH nfs-utils] Update autoconfig files to work with v2.71
In-reply-to: <165335765658.22265.136811943333028416@noble.neil.brown.name>
References: <165335765658.22265.136811943333028416@noble.neil.brown.name>
Date:   Thu, 26 May 2022 10:06:19 +1000
Message-id: <165352357925.11129.13126161631957337173@noble.neil.brown.name>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 24 May 2022, NeilBrown wrote:
> OpenSUSE recently updated autoconf to v2.71, and nfs-utils now doesn't
> build.  This patch fixes it.  It was mostly achieved with the autoupdate
> program.
>=20
> I haven't updated the AC_PREREQ(), but nor have I confirmed that it
> still works with v2.59.  It does seem to work with 2.69.

Actually, please don't apply this as-is.
I remembered that I left....
> @@ -50,8 +50,8 @@ AC_DEFUN([AC_LIBTIRPC_OLD], [
>    dnl Also must have the headers installed where we expect
>    dnl to look for headers; add -I compiler option if found
>    AS_IF([test "$has_libtirpc" =3D "yes"],
> -        [AC_CHECK_HEADERS([${tirpc_header_dir}/netconfig.h],
> -                          [AC_SUBST([AM_CPPFLAGS], ["-I${tirpc_header_dir}=
"])],
> +        [AC_CHECK_HEADERS([/usr/include/tirpc/netconfig.h],
> +                          [AC_SUBST([AM_CPPFLAGS], ["-I/usr/include/tirpc"=
])],
>                            [has_libtirpc=3D"no"])])
> =20

this in there - it ignores the config request an always uses
/usr/include/tirpc.  I need to work out how to do the right thing
without getting warnings.

Thanks,
NeilBrown
