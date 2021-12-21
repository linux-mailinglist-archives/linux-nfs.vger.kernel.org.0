Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC1247C925
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 23:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbhLUWSk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 17:18:40 -0500
Received: from out0.migadu.com ([94.23.1.103]:21823 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230085AbhLUWSj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 Dec 2021 17:18:39 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640125115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EgmW49Z3ZTrdtWHxdLVspzEiN24/kyfRtc2wPbWe+OM=;
        b=qsJ/ykDiJ586wkrQiCFe8yf9I416MTx1DKNji7Z0C0qHzfOKmFoWdVC3df9o2od+jFsjie
        BrGmcaYlfTEVV1osqcOclR286tYTQFCuV+KFzwr1z8fqQyR3jIFWU6zPBIuBNWhdfcuZOq
        BNX2EYM0pw2S9ILLERhWJvhC+xQveyM=
Date:   Tue, 21 Dec 2021 22:18:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Konstantin Ryabitsev" <konstantin.ryabitsev@linux.dev>
Message-ID: <f8459dd30802e4da915c63f6b70263e6@linux.dev>
Subject: Re: [PATCH] nfs: check nf pointer for validity before use
To:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Muhammad Usama Anjum" <usama.anjum@collabora.com>
Cc:     "Bruce Fields" <bfields@fieldses.org>,
        "Vasily Averin" <vvs@virtuozzo.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org
In-Reply-To: <05877B02-900A-4B22-9460-D2F0D20931DC@oracle.com>
References: <05877B02-900A-4B22-9460-D2F0D20931DC@oracle.com>
 <YcIjJ4jN3ax1rqaE@debian-BULLSEYE-live-builder-AMD64>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

December 21, 2021 3:00 PM, "Chuck Lever III" <chuck.lever@oracle.com> wro=
te:=0A> Btw, b4 complained about collabora.com's DKIM:=0A> =0A> [cel@bazi=
lle linux]$ b4 am=0A> https://lore.kernel.org/linux-nfs/YcIjJ4jN3ax1rqaE@=
debian-BULLSEYE-live-builder-AMD64/raw=0A> Grabbing thread from=0A> lore.=
kernel.org/linux-nfs/YcIjJ4jN3ax1rqaE%40debian-BULLSEYE-live-builder-AMD6=
4/t.mbox.gz=0A> Analyzing 1 messages in the thread=0A> Checking attestati=
on on all messages, may take a moment...=0A> ---=0A> =E2=9C=97 [PATCH] nf=
s: check nf pointer for validity before use=0A> ---=0A> =E2=9C=97 BADSIG:=
 DKIM/collabora.com=0A=0AThis is because collabora.com has DKIM canonical=
ization configured as "c=3Dsimple/simple". See my previous message to int=
el.com for why this should be changed to c=3Drelaxed/simple:=0A=0Ahttps:/=
/lore.kernel.org/lkml/20211214150032.nioelgvmase7yyus@meerkat.local/=0A=
=0AHope this helps.=0A=0A-K
