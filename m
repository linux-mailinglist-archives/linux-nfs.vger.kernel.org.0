Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B201F5BE75D
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Sep 2022 15:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiITNly (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Sep 2022 09:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiITNlx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Sep 2022 09:41:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90684E85C
        for <linux-nfs@vger.kernel.org>; Tue, 20 Sep 2022 06:41:47 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y8so3866551edc.10
        for <linux-nfs@vger.kernel.org>; Tue, 20 Sep 2022 06:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=20kZqGO4TCEIhRW6og60zkknfyJlZIkzzJvXuxPy7MA=;
        b=izxu1gEoQrcxaoQeHG/a4IdR9e5VGr1ML2fkqFw4OoYSv3k3ZOgryDb5aQKal/+7lM
         76M65yA4zMAgqxkutMLcH4X6c57wO26GpHAEkEltqF7ktU9p6yk+lhIK1jnyGKFOit5F
         +eRwhfg0aK5v5a16+ygwRKki9YEv8CGd9fUsJyoRR69tHmN71pL9JBLEKTu8Ms5Umaqd
         lToY6lV1+PzGkNL6FF1lIDMBfNKIqDQOEReDH7Irksn+1bdpgPj6y5ViOfBPvSYhjbYd
         WVB9+IW2Y7i3VlHNeucMeklo5yy8fWdndGiZjlY/i9AmdgAvIey3cs1WV1GEcuYTJE3r
         nPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=20kZqGO4TCEIhRW6og60zkknfyJlZIkzzJvXuxPy7MA=;
        b=HuaJcZ9Csdnz32eb6qsevMlop+r8DlmYFvirprBPDczzszhubSHD77/SLOx2I75cgs
         EPlfVHsK4/pJNAF645BCcaG13rf6bZc5jB6p9A4C2B7Vk/vwjASlZE/H8SCGcj4EqNHz
         JIw75WYZngc/1glkSWRCdH/3WfYOliQJ72qv9TUX9mH2xwD2vzAsbaClLplx5GaGnQ3u
         IWXpHrxXln35K8i7U4Euq1bOeBhL0sy+S1JR737zoagcGZU6aH7TsFcTZg10A6+26abg
         IE2NGSf/pMroR7nTaMgaTLFv757wJHwrUiUWgI/xEeUX+Fs2pfj902RUxBinGUZkJv83
         oAIQ==
X-Gm-Message-State: ACrzQf2dAX0QDq+/0SgIQZrvqj+/656ZplnUS3eecwMfj10fr38LSUWy
        vjbjGDQ7HDjeV2CkaN+Ow4ZR9zNgG9aFtXyaziO1s+M6J1Y=
X-Google-Smtp-Source: AMsMyM6wlGlCTfCzphQp+V2FxzWfnVj5KrEqO0zt4L6LE4P42XJQfQ/61foncJPHlLKwYCUqYK4Ewq0xb+yb9c09rCQ=
X-Received: by 2002:a05:6402:2898:b0:453:ab2e:65f9 with SMTP id
 eg24-20020a056402289800b00453ab2e65f9mr14093261edb.387.1663681305794; Tue, 20
 Sep 2022 06:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8zhTCcHTXsrhqYWZRAK9NZLFg4oZUzia8Uh-quGgZSjscMaw@mail.gmail.com>
In-Reply-To: <CAD8zhTCcHTXsrhqYWZRAK9NZLFg4oZUzia8Uh-quGgZSjscMaw@mail.gmail.com>
From:   Pradeep <pradeepthomas@gmail.com>
Date:   Tue, 20 Sep 2022 06:41:34 -0700
Message-ID: <CAD8zhTCEfUycDT2jKJG4TNVGFUqe2J-=7On=vyypkA=eGFcGZw@mail.gmail.com>
Subject: Re: EREMOTE error on NFSv4 CREATE RPC with latest kernel.
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Any thoughts or suggestions on this issue?

Thanks

On Mon, Sep 12, 2022 at 7:29 AM Pradeep <pradeepthomas@gmail.com> wrote:
>
> Hello,
>
> We have created a referral-based =E2=80=9Cdistributed=E2=80=9D namespace =
spread across
> multiple Linux nodes using the local file system. The server
> implementation uses nfs-ganesha. Within an NFSv4 export, we place
> top-level directories (under export root) on different nodes for =E2=80=
=9Cload
> balancing=E2=80=9D. These directories simulate separate filesystems (sepa=
rate
> fsids) and return fs_locations when queried by the client. Note that
> currently, the Linux NFS client only queries for fs_locations
> attribute (handling of NFS4ERR_MOVED) on a =E2=80=9Clookup=E2=80=9D VFS o=
peration.
>
> To allow the client to be able to create top-level directories, we
> must ensure that the mkdir succeeds (since the client cannot handle
> NFS4ERR_MOVED on CREATE), but the directory created to be potentially
> placed on a different node than the one client is connecting to. To do
> this, we internally forward the mkdir request to another node where it
> gets created.
>
> Until recently, we were able to return a zero-byte filehandle in the
> GETFH response for CREATE (a compound of PUTFH, CREATE, GETFH,
> GETATTR). This forces the Linux client to issue a LOOKUP on the
> directory name, get an NFS4ERR_MOVED in response and subsequently get
> redirected to the correct node.
>
> See code here for reference that forces a LOOKUP on zero byte FH:
> https://elixir.bootlin.com/linux/latest/source/fs/nfs/dir.c#L2237
>
> Of course, this isn=E2=80=99t documented in the protocol, although the
> protocol does not explicitly disallow =E2=80=9Cjunctions=E2=80=9D to be c=
reated by the
> client.
>
> Trond=E2=80=99s recent change on file handle validation in RPC decoding l=
ayer
> now makes the zero-byte file handle invalid - see
> https://git.linux-nfs.org/?p=3Dtrondmy/linux-nfs.git;a=3Dcommitdiff;h=3De=
b3d58c68e39fad68d8054e0324eb06d82dcedbb;hp=3D3d66bae156a652be18e278f3c88bc3=
e069ae824b.
>
> This is probably done (correctly) for other reasons. However, it does
> prevent the client from =E2=80=9Crecovering=E2=80=9D the filehandle of a =
newly created
> directory through a subsequent lookup. Other options like returning a
> correct filehandle (which we could obtain from the remote node) would
> not work, since the client is not informed of fs_locations. Similarly,
> NFS4ERR_BADHANDLE or NFS4ERR_STALE will not perform any =E2=80=9Crecovery=
=E2=80=9D
> since the directory isn=E2=80=99t known yet to have a separate fsid.
>
> Suggestions on how/if we can support junction creates from the client?
>
> Thanks,
> Pradeep
