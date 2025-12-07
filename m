Return-Path: <linux-nfs+bounces-16983-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE27CAB2AC
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Dec 2025 09:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C854305AC70
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Dec 2025 08:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0152D3755;
	Sun,  7 Dec 2025 08:25:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F20221D96;
	Sun,  7 Dec 2025 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765095916; cv=none; b=RekbjQM4jNbnAw1hjwqv/IolNSgm/QB3DiTvkf1f5ZJajNOYN7R5ZCtOCGsjVhUtNztFMY6CiGUQjmw7QVbv8gAjMdZjK2WCKcC2yHbVmd7ceLxIZilebp3q3/Oq3UOjdZxpbdOXCVhA0ZzbyB4W4AqMTNqWkREEL+n1s57mv6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765095916; c=relaxed/simple;
	bh=ce2Iz7KBrQEhj0edCa2MiL+MGT6pOrlTOxOzZROaWF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ttaU/o+HP+nnC7rB3NNbsSEN2QOtPDOcZJdWf4Z9jq4CtSO4sSARr9A4+7y5jc4bk75UdBakd8D/cOi0h+86l8kMy0YXtRA0DtqnAn72ZvjSvYb8v/X1Epcs3GrsgD2aY9A7cofwPCSHMP48i2aF+uWLtUqQZQ+4ywo4Z5iSvFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-01 (Coremail) with SMTP id qwCowADHWsrbOTVpCrFeAw--.36508S2;
	Sun, 07 Dec 2025 16:24:59 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: cel@kernel.org
Cc: Dai.Ngo@oracle.com,
	bfields@fieldses.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	lihaoxiang@isrc.iscas.ac.cn,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	stable@vger.kernel.org,
	tom@talpey.com
Subject: Re: [PATCH] nfsd: Drop the client reference in client_states_open()
Date: Sun,  7 Dec 2025 16:24:58 +0800
Message-Id: <20251207082458.18833-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0ec5a1be-372b-4a0a-9b64-099b1d8bf710@app.fastmail.com>
References: <0ec5a1be-372b-4a0a-9b64-099b1d8bf710@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADHWsrbOTVpCrFeAw--.36508S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyxJryUCry5AF4ktF4UXFb_yoW8JFWUpr
	4xJa15KrWktFWxWFsrZan0qa4ruw1vyr18GrZYq3WrAF93Zr15KF1F9wn5uF45CrWfZw1S
	qr4UKFWjg39xZFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUGVWUWwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBgoJE2k088FT7AACsE

Hi, Chuck!

Sat, 06 Dec 2025 09:37:44 -0500, Chuck Lever wrote:
> >
> On Sat, Dec 6, 2025, at 2:38 AM, Haoxiang Li wrote:
> > In error path, call drop_client() to drop the reference
> > obtained by get_nfsdfs_clp().
> >
> > Fixes: a204f25e372d ("nfsd: create get_nfsdfs_clp helper")

> An argument could be made that 78599c42ae3c ("nfsd4: add file
> to display list of client's opens") is where the reference
> counting was first broken. Would you mind if I updated the
> Fixes: tag when I apply this?

Thanks for pointing out the incorrect Fixes tag in the patch.
Please feel free to correct it.

-Haoxiang Li

> > Cc: stable@vger.kernel.org
> > Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> > ---
> > fs/nfsd/nfs4state.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 8a6960500217..caa0756b6914 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -3097,8 +3097,10 @@ static int client_states_open(struct inode 
> > *inode, struct file *file)
> >  	 	 return -ENXIO;
> >
> > 	 ret = seq_open(file, &states_seq_ops);
> > -	 if (ret)
> > +	 if (ret) {
> > +		 drop_client(clp);
> > 		 return ret;
> > +	 }
> > 	 s = file->private_data;
> > 	 s->private = clp;
> >  	 return 0;
> > -- 
> > 2.25.1

> -- 
> Chuck Lever


