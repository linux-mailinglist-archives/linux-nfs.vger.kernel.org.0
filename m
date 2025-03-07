Return-Path: <linux-nfs+bounces-10519-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C80A55F0E
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Mar 2025 05:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0CA16A5BD
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Mar 2025 04:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F8E7DA7F;
	Fri,  7 Mar 2025 04:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JCYWO7V+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E0F190485
	for <linux-nfs@vger.kernel.org>; Fri,  7 Mar 2025 04:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741320010; cv=none; b=Zq/EucNypqz0rUorEsjLYfAvQVIatfJGAYOVFH7DPsfqPz8pSkb/wWytJzgHV5dzBSo1j5AnWLc1Gr0x4wPOqJZOhBK4WvajbU3cWJ82NrOQVaVgZ2Tl3Et95vz+JY5WyEdonPBMTGrNy+FfD1V5T+SAqSJj8B54UAGYLQjaQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741320010; c=relaxed/simple;
	bh=/EJHP+8TfDAtSkvGsyq8r00JUKNY7IZDhYhYCIDTFlg=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=K5GVqGBVgNW/abfG2UOQ0kztitpUcbNnrVQxIMP/le1S4G4TV1/s+HF0g4UrRi7JAbhEkCbeHtOcFyILJR1ZRMRoQXy7cocM7HsTOsp+Y6iLc7Bcs8Jtc4UymbJyCFtrga7HraxaRvDbL90ianVzK4+D60Ri9ZmBPe4rfXB1Vuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JCYWO7V+; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250307035959epoutp0387c97a4fa0f9bb52fb4cb2ec7171901d~qaVBmZxkQ1037510375epoutp030
	for <linux-nfs@vger.kernel.org>; Fri,  7 Mar 2025 03:59:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250307035959epoutp0387c97a4fa0f9bb52fb4cb2ec7171901d~qaVBmZxkQ1037510375epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741320000;
	bh=LzTQRzJ1HeapOI4JPtLfPUdsHjeO+Cq77SQ6lp2CbFM=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=JCYWO7V+45pdSoIjM5yHykB7KTzMwPfqt91RdpdncklmHEUKpAtYiYUxwXg4Lk4b9
	 Nys3hI1DYMVdKKvoGyxPzPJUtkiRe0xK7jT23gtLk1Qo0tbBAxyi0i6015pckZpdCt
	 bNwH3EZw3W7CrBMf5H+iEZqFVzUZ32xoGW0cc+Aw=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250307035959epcas5p44d3562a116c24c9a9f1f3305c3197fc5~qaVBGt9jN1240212402epcas5p4f;
	Fri,  7 Mar 2025 03:59:59 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-74-67ca6f3f0db4
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	18.E7.19933.F3F6AC76; Fri,  7 Mar 2025 12:59:59 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH 2/2] NFSD: fix race between nfsd registration and
 exports_proc
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From: Maninder Singh <maninder1.s@samsung.com>
To: Jeff Layton <jlayton@kernel.org>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>, "neilb@suse.de" <neilb@suse.de>,
	"okorniev@redhat.com" <okorniev@redhat.com>, "Dai.Ngo@oracle.com"
	<Dai.Ngo@oracle.com>, "tom@talpey.com" <tom@talpey.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chung-Ki Woo
	<chungki0201.woo@samsung.com>, Shubham Rana <s9.rana@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <c5d6d532ca6bb39f02629402ed289700589ded19.camel@kernel.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250307032948epcms5p5280f36a460ef7a4def620096699a1df2@epcms5p5>
Date: Fri, 07 Mar 2025 08:59:48 +0530
X-CMS-MailID: 20250307032948epcms5p5280f36a460ef7a4def620096699a1df2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7bCmuq59/ql0g0fzxCz+333OZHH6+xV2
	i/mLNrNZ/Fy2it3i8q45bBYXDpxmtehbPYvRYu/8BhaLSc8+sVt8f3yJ0eLUr1NMDtwem1Z1
	snl8fHqLxeP9vqtsHn1bVjF6bD5d7XH5yRVGj8+b5ALYo7hsUlJzMstSi/TtErgyZvesZin4
	J1yxa0svcwPjNYEuRk4OCQETiWXnbjF1MXJxCAnsZpT4uP8QcxcjBwevgKDE3x3CIDXCAiES
	t44eYQOxhQQUJS7MWMMIUiIsYCDxa6sGSJhNQE9i1a49LCBjRASWMUns//CeGcRhFjjHKPFs
	4hN2iGW8EjPan7JA2NIS25dvZQSxOQU8JC50/mCCiItK3Fz9lh3Gfn9sPiOELSLReu8sM4Qt
	KPHg526ouIzE6s29UDOrJZ6+PscGslhCoIVRYt9umCJzifVLVoEN5RXwlfj7+wwriM0ioCrR
	e/M9C8g3EgIuEjd+qYGEmQXkJba/nQMOB2YBTYn1u/QhpshKTD21jgmihE+i9/cTJpi3dsyD
	sVUlWm5uYIV58fPHj1CneUi07jjJBgnnn4wSsy/dYJzAqDALEdSzkGyehbB5ASPzKkbJ1ILi
	3PTUYtMCo7zUcr3ixNzi0rx0veT83E2M4BSl5bWD8eGDD3qHGJk4GA8xSnAwK4nwCm4+mS7E
	m5JYWZValB9fVJqTWnyIUZqDRUmct3lnS7qQQHpiSWp2ampBahFMlomDU6qBiUWHuVfM6pzr
	eVepyvWLlOfnyujeyHhrqnCDz4rrp9lvAaVkjznG0ZtFNXyLtjP6+4QFCHE8Z+MRynAM27TK
	dv3vV9HzC7c91a5uaNj4ypd3Syfz9X+GjnG5z0+dfLxCmCv95Mfwvw86DLLa8rTavv0N/Zgx
	9/Iew55ds09/P/kgf5u46kUh25+PQpbr6Rbnsr77F3li9Tw3jzdWjd+ahFUvBZlm9a0rnPWr
	/rj6gvt27YcS60J5Luu2NKb1tSmeWTlL/NLn93slEmZu+9r8Q/z/MS6njT5/HdwdDTOmPmRf
	7xjbrjSF8f75cNGwSI5vXtltX740RL5at80kK4DvsJVZH/uSY8eDiovV2aYqsRRnJBpqMRcV
	JwIAMVpi/8ADAAA=
X-CMS-RootMailID: 20250306092021epcas5p41133e5a273e547d39ae8b724c9eca23f
References: <c5d6d532ca6bb39f02629402ed289700589ded19.camel@kernel.org>
	<20250306092007.1419237-1-maninder1.s@samsung.com>
	<20250306092007.1419237-2-maninder1.s@samsung.com>
	<CGME20250306092021epcas5p41133e5a273e547d39ae8b724c9eca23f@epcms5p5>

Hi,

> > As of now nfsd calls create_proc_exports_entry() at start of init_nfsd
> > and cleanup by remove_proc_entry() at last of exit_nfsd.
> > 
> > Which causes kernel OOPs if there is race between below 2 operations:
> > (i) exportfs -r
> > (ii) mount -t nfsd none /proc/fs/nfsd
> > 
> > for 5.4 kernel ARM64:
> > 
> > CPU 1:
> > el1_irq+0xbc/0x180
> > arch_counter_get_cntvct+0x14/0x18
> > running_clock+0xc/0x18
> > preempt_count_add+0x88/0x110
> > prep_new_page+0xb0/0x220
> > get_page_from_freelist+0x2d8/0x1778
> > __alloc_pages_nodemask+0x15c/0xef0
> > __vmalloc_node_range+0x28c/0x478
> > __vmalloc_node_flags_caller+0x8c/0xb0
> > kvmalloc_node+0x88/0xe0
> > nfsd_init_net+0x6c/0x108 [nfsd]
> > ops_init+0x44/0x170
> > register_pernet_operations+0x114/0x270
> > register_pernet_subsys+0x34/0x50
> > init_nfsd+0xa8/0x718 [nfsd]
> > do_one_initcall+0x54/0x2e0
> > 
> > CPU 2 :
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> > 
> > PC is at : exports_net_open+0x50/0x68 [nfsd]
> > 
> > Call trace:
> > exports_net_open+0x50/0x68 [nfsd]
> > exports_proc_open+0x2c/0x38 [nfsd]
> > proc_reg_open+0xb8/0x198
> > do_dentry_open+0x1c4/0x418
> > vfs_open+0x38/0x48
> > path_openat+0x28c/0xf18
> > do_filp_open+0x70/0xe8
> > do_sys_open+0x154/0x248



> To make sure I understand, the race is that sometimes the exports
> interface gets created before the net namespace is set up, and then
> that causes GPFs when exports_net_open tries to access the nfsd_net?
> 


Yes, Sometime at time of module init this happened as I shared state of 2 CPUs at
time of crash.
and sometimes it occurs when module was unloading and user space was accessing it.

So I though interface to user shall be exported late during init and clean up early.
But what is actual position for that I was not sure, So I moved to last at time of init
and first at time of clean up.

And originally at time of 4.13 kernel this cleanup was the first thing to do in exit time.
but with time to fixing other issues, its position got changed.

https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=027690c75e8fd91b60a634d31c4891a6e39d45bd
https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=bd5ae9288d6451bd346a1b4a59d4fe7e62ba29b7
https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=6f6f84aa215f7b6665ccbb937db50860f9ec2989

Which caused this kernel OOPs I think.

Thanks,
Maninder Singh

