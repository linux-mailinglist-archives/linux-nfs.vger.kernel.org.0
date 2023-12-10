Return-Path: <linux-nfs+bounces-475-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 431BF80BBDD
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Dec 2023 15:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D717D1F20F5E
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Dec 2023 14:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE2B156DF;
	Sun, 10 Dec 2023 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7JZwigz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50238DB
	for <linux-nfs@vger.kernel.org>; Sun, 10 Dec 2023 06:55:33 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ceb27ec331so2264943b3a.1
        for <linux-nfs@vger.kernel.org>; Sun, 10 Dec 2023 06:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702220132; x=1702824932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g3Wyb1Xwoi7wirfV8GlH/J6f/ClnX7fq8xd/YFQIrDk=;
        b=c7JZwigzbw91109d80MPkUNKSwaOYkI03DdLgCXI5obTNxKJ3uCQs66+b6zEYgSoeX
         XoAALORlMwuXqNe4cb9uap5RbCZtdAjdrrpxUarET2fyvpUz0oBhBSzSD1FXYWHxiD6X
         HyWXLTl5KeaNiVCBXrkDsYvnYggc+5CLq38UNd6vOXr5nTOj4f4LodKuQeA+xFoLpqcO
         f1semeVggurNJGHQ15Y3EdpP32sxyyou9nZEPeuhwkqKEu4z8zvKIRE+uXeP8PJ5/LHn
         XYwPA3OL5UjuwLcYW4lt870wBNuxT/OQ8sKsJE1pzqLjFmLWOw68GcEW1IIe8HXiTVUJ
         XriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702220132; x=1702824932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3Wyb1Xwoi7wirfV8GlH/J6f/ClnX7fq8xd/YFQIrDk=;
        b=KMdB9CHjlv2LUIDO2kiSDC6QZcKuw9EdzWl90US90evJwipD/WErEIsGsUsGd8dXS4
         CDE2U/HG1VxnBBS89hIyUB85ihpEP1HdRzKnXiPRVAom19Zd+i1Y0SwUlQOM+liElSKV
         FBSUzeC+F4QRNAEaCg0435R4h3EBLwRxp4z4FzauYFUpvTeHMP0feCHTZTYN6cZWhlRH
         X5jXF/mvJ0i6D3P//O+ACEUpeLaBIxBNjPh++wJWV24agoWHEvbbTFXQpVj2Mxfd8H0l
         By5GyIUskJ5YqnQpc+6U8PQyCWE4fa6ng/DnIk+16Xuqxj9YDet6lWiEcvY8YS2FrnZb
         MkpA==
X-Gm-Message-State: AOJu0Yx5TjkpV/JSZBzK28HSMbMmQhU5gvY/FDNsHd0WU1NuV1Puoqxx
	CkrI+mRUbTN7OrR/1iPH8obFjk1JWov4m+9XZTtUuUtmRNuBGEsK
X-Google-Smtp-Source: AGHT+IG75pUbcx2cDrx29uKCSGL8oZcWMSU6d4C0g84HhPqwq/GyPUQRu/8mySUKbTAnMtF3tE3iAjVv3RmkmwWb5zE=
X-Received: by 2002:a05:6a00:8806:b0:6ce:7d15:9a80 with SMTP id
 ho6-20020a056a00880600b006ce7d159a80mr999147pfb.61.1702220132477; Sun, 10 Dec
 2023 06:55:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ditang chen <ditang.c@gmail.com>
Date: Sun, 10 Dec 2023 22:55:21 +0800
Message-ID: <CAHnGgyHoyce3Fi5KgCJvHg52R8GumLphPhpzdvZKrwEXy0BnsA@mail.gmail.com>
Subject: nfsd:Multiple nfs clients with the same hostname cause session exceptions
To: linux-nfs <linux-nfs@vger.kernel.org>
Cc: chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Multiple nfs clients with the same hostname cause session exceptions,
the new client find confirmed nfs4_client by name in the
nfsd4_create_session
and then will release the se_hash list=EF=BC=9A

old =3D find_confirmed_client_by_name(&unconf->cl_name, nn);
if (old) {
    status =3D mark_client_expired_locked(old);
    if (status) {
        old =3D NULL;
        goto out_free_conn;
    }
    trace_nfsd_clid_replaced(&old->cl_clientid);
}
move_to_confirmed(unconf);

Is there any other option, such as IP instead of host name, which is
usually unique=EF=BC=9F

Dec  1 22:42:32 dd kernel: nfsd4_exchange_id rqstp=3D000000006668b520
exid=3D00000000a44d3b72 clname.len=3D35 clname.data=3D000000007b1b5592
ip_addr=3D192.168.122.130 flags 101, spa_how 0
Dec  1 22:42:32 dd kernel: nfsd4_exchange_id seqid 0 flags 20001
Dec  1 22:42:32 dd kernel: check_slot_seqid enter. seqid 1 slot_seqid 0
Dec  1 22:42:32 dd kernel: alloc_cld_upcall: allocated xid 10
Dec  1 22:42:32 dd rpc.mountd[25713]: v4.2 client attached:
0xe21bb8c66569eeaf from "192.168.122.130:894"
Dec  1 22:42:32 dd rpc.mountd[25713]: v4.2 client detached:
0xe21bb8c56569eeaf from "192.168.122.93:791"
Dec  1 22:42:32 dd kernel: __find_in_sessionid_hashtbl:
1701441199:3793467590:5:0
Dec  1 22:42:32 dd kernel: nfsd4_sequence: slotid 0
Dec  1 22:42:32 dd kernel: check_slot_seqid enter. seqid 1 slot_seqid 0
Dec  1 22:42:32 dd kernel: nfsd: fh_compose(exp 103:08/128 /, ino=3D128)
Dec  1 22:42:32 dd kernel: --> nfsd4_store_cache_entry slot 000000006ef6f42=
2
Dec  1 22:42:32 dd kernel: __find_in_sessionid_hashtbl:
1701441199:3793467590:5:0
Dec  1 22:42:32 dd kernel: nfsd4_sequence: slotid 0
Dec  1 22:42:32 dd kernel: check_slot_seqid enter. seqid 2 slot_seqid 1
Dec  1 22:42:32 dd kernel: alloc_cld_upcall: allocated xid 11
Dec  1 22:42:32 dd kernel: --> nfsd4_store_cache_entry slot 000000006ef6f42=
2
Dec  1 22:42:36 dd kernel: __find_in_sessionid_hashtbl:
1701441199:3793467589:4:0
Dec  1 22:42:36 dd kernel: __find_in_sessionid_hashtbl: session not found
Dec  1 22:42:36 dd kernel: nfsd4_destroy_session: 1701441199:3793467589:4:0
Dec  1 22:42:36 dd kernel: __find_in_sessionid_hashtbl:
1701441199:3793467589:4:0
Dec  1 22:42:36 dd kernel: __find_in_sessionid_hashtbl: session not found
Dec  1 22:42:36 dd kernel: nfsd4_exchange_id rqstp=3D000000006668b520
exid=3D00000000a44d3b72 clname.len=3D35 clname.data=3D000000007b1b5592
ip_addr=3D192.168.122.93 flags 101, spa_how 0
Dec  1 22:42:36 dd kernel: nfsd4_exchange_id seqid 0 flags 20001
Dec  1 22:42:36 dd kernel: check_slot_seqid enter. seqid 1 slot_seqid 0
Dec  1 22:42:36 dd kernel: alloc_cld_upcall: allocated xid 12
Dec  1 22:42:36 dd rpc.mountd[25713]: v4.2 client attached:
0xe21bb8c76569eeaf from "192.168.122.93:791"
Dec  1 22:42:36 dd rpc.mountd[25713]: v4.2 client detached:
0xe21bb8c66569eeaf from "192.168.122.130:894"
Dec  1 22:42:36 dd kernel: __find_in_sessionid_hashtbl:
1701441199:3793467591:6:0
Dec  1 22:42:36 dd kernel: nfsd4_sequence: slotid 0
Dec  1 22:42:36 dd kernel: check_slot_seqid enter. seqid 1 slot_seqid 0
Dec  1 22:42:36 dd kernel: nfsd: fh_compose(exp 103:08/128 /, ino=3D128)
Dec  1 22:42:36 dd kernel: --> nfsd4_store_cache_entry slot 00000000e1f66c2=
4
Dec  1 22:42:36 dd kernel: __find_in_sessionid_hashtbl:
1701441199:3793467591:6:0
Dec  1 22:42:36 dd kernel: nfsd4_sequence: slotid 0
Dec  1 22:42:36 dd kernel: check_slot_seqid enter. seqid 2 slot_seqid 1
Dec  1 22:42:36 dd kernel: alloc_cld_upcall: allocated xid 13
Dec  1 22:42:36 dd kernel: --> nfsd4_store_cache_entry slot 00000000e1f66c2=
4
Dec  1 22:43:33 dd kernel: __find_in_sessionid_hashtbl:
1701441199:3793467590:5:0
Dec  1 22:43:33 dd kernel: __find_in_sessionid_hashtbl: session not found
Dec  1 22:43:33 dd kernel: nfsd4_destroy_session: 1701441199:3793467590:5:0
Dec  1 22:43:33 dd kernel: __find_in_sessionid_hashtbl:
1701441199:3793467590:5:0
Dec  1 22:43:33 dd kernel: __find_in_sessionid_hashtbl: session not found

