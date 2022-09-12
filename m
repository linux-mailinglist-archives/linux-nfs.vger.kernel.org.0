Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BBA5B5C33
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 16:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiILO3d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 10:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiILO3a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 10:29:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21DF33355
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 07:29:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id u6so13024831eda.12
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=RMfellM8EsS5NNfYNUH1wed5lqjBR+CLqiQJlPNlGdc=;
        b=pvuLq2auKbJ7YsaXjnVhbrmUl+aXkUYqxb0fuH2nVHb5HqrIjQP33lQILpYWpF2ake
         r+giS42iQTIxs7j8DO0wkVHcuwZV0d1IzaBaaHPhY1hBGShk9HHpNa62vTzs6qeuTrWi
         u5qAjdjTyPr1HVHfKSDzxj4hwGhMM4eaRfuBqSgChw5K8ZPRqODsgB6CemKAmXAFtnz7
         w0UG5otlXMFrJZ7kk0LaOSJpKvapiVtpCTVLeBAe91jEbIlQIDwplML92MDGktLKbVrq
         vu+EfV1CmeS3ZYPwvb5ZT7FhAcaP0RCrs3QXF449+Za2hhhaCIW1iaATGgvfRVrkpSop
         Bm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RMfellM8EsS5NNfYNUH1wed5lqjBR+CLqiQJlPNlGdc=;
        b=2cs5oaZxG/fcYBukFVx/Ek5AbxH3N0751LvlI2TgDeZuS9XBDHUwYiQROX1uWCQtdt
         uoKeBtAHPZZ5/BxDswTiELxm1Wss+R5Vcio3cjDWH+BK70IpV45uhAIUQwa+jpj0QkW3
         KWv9zXzqmuBOBxzv8o7W+bJ9QRZenGIS160eOZ2uoNicKnXDDy8ZrXeW50IvHsoYbd5D
         UpzN+/Y8PbO/GCDElhrZEPTQhbf29/l68E7hY2l0YBnu0OfcXFRN1aW1mip+cEs8Tnd8
         ImeCnLTZyguw5r+AMv7ctxO1A4zDc3JkxeqRz4nny8NGAdmgXwtaH8n8+hCRRHxCUqE0
         yi6g==
X-Gm-Message-State: ACgBeo0s70MbFbaj4bj8SV1SmCdQZhd07fRovrj91ugaZRLWU2WDH2pU
        G8ytwVxXttpMVzPUT9n7PAr6IR1uyNakMEHj1DYXUtHQOycyVw==
X-Google-Smtp-Source: AA6agR5PWr4HRjNJkSei5O3AxaVgZWSZGFKzYtkLeaAvK5VpyeUyqkhAYS9XiiOFOwlpQmI/QBGLriO3TNvqVs0/chw=
X-Received: by 2002:a05:6402:5ca:b0:43b:6e01:482c with SMTP id
 n10-20020a05640205ca00b0043b6e01482cmr22919228edx.189.1662992965731; Mon, 12
 Sep 2022 07:29:25 -0700 (PDT)
MIME-Version: 1.0
From:   Pradeep <pradeepthomas@gmail.com>
Date:   Mon, 12 Sep 2022 07:29:14 -0700
Message-ID: <CAD8zhTCcHTXsrhqYWZRAK9NZLFg4oZUzia8Uh-quGgZSjscMaw@mail.gmail.com>
Subject: EREMOTE error on NFSv4 CREATE RPC with latest kernel.
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

We have created a referral-based =E2=80=9Cdistributed=E2=80=9D namespace sp=
read across
multiple Linux nodes using the local file system. The server
implementation uses nfs-ganesha. Within an NFSv4 export, we place
top-level directories (under export root) on different nodes for =E2=80=9Cl=
oad
balancing=E2=80=9D. These directories simulate separate filesystems (separa=
te
fsids) and return fs_locations when queried by the client. Note that
currently, the Linux NFS client only queries for fs_locations
attribute (handling of NFS4ERR_MOVED) on a =E2=80=9Clookup=E2=80=9D VFS ope=
ration.

To allow the client to be able to create top-level directories, we
must ensure that the mkdir succeeds (since the client cannot handle
NFS4ERR_MOVED on CREATE), but the directory created to be potentially
placed on a different node than the one client is connecting to. To do
this, we internally forward the mkdir request to another node where it
gets created.

Until recently, we were able to return a zero-byte filehandle in the
GETFH response for CREATE (a compound of PUTFH, CREATE, GETFH,
GETATTR). This forces the Linux client to issue a LOOKUP on the
directory name, get an NFS4ERR_MOVED in response and subsequently get
redirected to the correct node.

See code here for reference that forces a LOOKUP on zero byte FH:
https://elixir.bootlin.com/linux/latest/source/fs/nfs/dir.c#L2237

Of course, this isn=E2=80=99t documented in the protocol, although the
protocol does not explicitly disallow =E2=80=9Cjunctions=E2=80=9D to be cre=
ated by the
client.

Trond=E2=80=99s recent change on file handle validation in RPC decoding lay=
er
now makes the zero-byte file handle invalid - see
https://git.linux-nfs.org/?p=3Dtrondmy/linux-nfs.git;a=3Dcommitdiff;h=3Deb3=
d58c68e39fad68d8054e0324eb06d82dcedbb;hp=3D3d66bae156a652be18e278f3c88bc3e0=
69ae824b.

This is probably done (correctly) for other reasons. However, it does
prevent the client from =E2=80=9Crecovering=E2=80=9D the filehandle of a ne=
wly created
directory through a subsequent lookup. Other options like returning a
correct filehandle (which we could obtain from the remote node) would
not work, since the client is not informed of fs_locations. Similarly,
NFS4ERR_BADHANDLE or NFS4ERR_STALE will not perform any =E2=80=9Crecovery=
=E2=80=9D
since the directory isn=E2=80=99t known yet to have a separate fsid.

Suggestions on how/if we can support junction creates from the client?

Thanks,
Pradeep
