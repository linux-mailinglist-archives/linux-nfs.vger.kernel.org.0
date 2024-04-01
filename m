Return-Path: <linux-nfs+bounces-2593-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D688894799
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Apr 2024 01:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E99E1C218CC
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 23:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5694A56B6B;
	Mon,  1 Apr 2024 23:20:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from out198-173.us.a.mail.aliyun.com (out198-173.us.a.mail.aliyun.com [47.90.198.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22A856B65
	for <linux-nfs@vger.kernel.org>; Mon,  1 Apr 2024 23:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712013657; cv=none; b=q1gqTRLA6susoLn7wMciuTInrF3DIaBnWPZ4li093Wat3J4gTSz49IdnAAuwTEztuEVWdLU76f6VfUBNk2X4NPOiGJaYkqYnCj4zFrRQ8ApRBZlYdLrafDYPSgasiPlaZOQgHxjKbRs7f1P9OtDDjGARgWyqFHzKfipMvyYzZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712013657; c=relaxed/simple;
	bh=EkTCueco7Hd9UmWL0jwv7RjMgaNaXN+ZHWRL4eR/eXQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=cnQOu3/zVwz5no9KiPxsWP76L3pJnxMfqHrOPrezma18P92rUM3FV4GdBsBbXafhFO5QL/MjoLe1NNEt1A+8fpJ4Bcf3kAgBZLz3gknQUDlKE3JpW7skvhcq60Cmt/mnMkjoa+59mg//rrihQEQSziCsUuN+XIOO22+7E1DVsyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1501871|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.013625-0.000309001-0.986066;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.X.abb6H_1712009971;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.X.abb6H_1712009971)
          by smtp.aliyun-inc.com;
          Tue, 02 Apr 2024 06:19:32 +0800
Date: Tue, 02 Apr 2024 06:19:32 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: one more patch(nfsd: fix potential race in nfs4_find_file) for 6.1.83+ ?
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <E9D90677-6F0A-44BF-A7CC-771CEC8B41DE@oracle.com>
References: <20240401190527.7D1D.409509F4@e16-tech.com> <E9D90677-6F0A-44BF-A7CC-771CEC8B41DE@oracle.com>
Message-Id: <20240402061931.7D26.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.06 [en]

Hi,

> 
> > On Apr 1, 2024, at 7:05?AM, Wang Yugui <wangyugui@e16-tech.com> wrote:
> > 
> > Hi,
> > 
> > We had 13 nfsd patches in 6.1.83, do we need one more patch(*1)?
> > 
> > *1:
> > bd6aaf781dae :Jeff Layton: nfsd: fix potential race in nfs4_find_file
> 
> This one went in after v6.2 (where I drew a line in
> the sand) and looked more like a clean-up than a bug fix.
> 
> Is the kernel misbehaving? Why do you believe this one
> needs to be backported?

Yet not find any kernel misbehaving.

just fs/nfsd/filecache.c related.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/04/02



