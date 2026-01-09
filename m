Return-Path: <linux-nfs+bounces-17716-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92672D0C6CD
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 23:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 268F63009D59
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 22:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C163019A4;
	Fri,  9 Jan 2026 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOo6lp6o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E613043DE
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767996814; cv=none; b=j2lk7/C0rEFCBNxQtU/AoPZ4D9U+2+rILiwu8McB7K1x7yoecW0EgHeTzdoCxOcBnv7yGaMsvqeCa1y6reW5nbeN5TSteLgO9Kg2gu/ieA9nXEAZKzfw+wrdMsAyThc2Q1xvl4fjO7FjSwOCindjUUScoWNE7lXrv3wfdAail7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767996814; c=relaxed/simple;
	bh=gwAApusC+hgiVEWFppbTjXW/2mF5tt62NKZaiFjKsUI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=THK2kuM9IuQz5pLnPSep7C8QTe45L3zcTe9qdfL5SCHgL0ZRGQJmf8FLkejoaz1rDvhBkd1o0hnVODLJlXGd+UiUL1gEDB9WJey0GEYIEAuZ0u57uI32DlpdMHccTfQMXdDvy6oOwyxn+3WXi1ZGvtnFaEnCx9HAhpYXhRS73zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOo6lp6o; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88a35a00506so64483096d6.2
        for <linux-nfs@vger.kernel.org>; Fri, 09 Jan 2026 14:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767996811; x=1768601611; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwAApusC+hgiVEWFppbTjXW/2mF5tt62NKZaiFjKsUI=;
        b=cOo6lp6owwGzyOeHhg89GBoNdRKzPOTxIQubFO/+kJuw47e8nFopjAeMF0jhQYH6pt
         hivSaxBDMLOaFvrbdnSLthVh8sIiQNCwjhqtyQ92UTb54fArodpwZT5bv/hqfTFG/awN
         V1Bz7KoFSwHlWmX3UvxUbMT/QCSB31CQvCW8swVKoMg2/H3e4N+DcceYEq0MMhzlhblc
         ujg1w9Ni6DDTt9RQGzmeXERsC0BTWqiRGtN9sqp2Me/Ju5J15HWMPKSEiAqMSxqG7KqE
         c8fXcYNcptjq2NMmtu5KC7b5v2ISXggjyV2hmkTGoS3hLEG4LPbkOvfX4aY2aWKRz7cf
         hqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767996811; x=1768601611;
        h=to:subject:message-id:date:from:reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwAApusC+hgiVEWFppbTjXW/2mF5tt62NKZaiFjKsUI=;
        b=hQFu+hXYgF/qW75szxtDS+QyJMWsqnF6M2ExeLal7eqWesH8EaWM6+xxL9sWk6JrCy
         ZpE7WsXxVF9YVAwgxF4dlPMoy5eZ96GgxjMsqvjwKnWiSfN2cOvaj6uyPMnZI1tcqwZS
         XUMfCyBOZMkombdFWtT0HCRvGHt0IExbNOxXY/kRr7PJYKwbRqn77ab8+yRedMPfq9d/
         7lSFKbg8OhUOrhJm4R1SZhY8vDddf2MdWgi44t7F2vwQyJUgWYoFwqZYmXDBX6559gOy
         oIKrTU3dC55uhlKSmASFeSMr3vMjQBzTBPajLbI822MX9LYyMWdf3s+ciD2WpKbHcYBB
         PC0w==
X-Gm-Message-State: AOJu0YxWE82heEW1re1pOIZkePBk5T60h4UOSh0YtTjKWhvCEN6xIU65
	7nHUbWQfHgTB39Cj76E5TVWzvOOXm5WWqntcTlZ5601lxqmKh7NJiIeOZ++QAahuq78qfbLpQoN
	MFYqWdsYBR85ddmldIt3ykosoJUylK2pzlfd2
X-Gm-Gg: AY/fxX40FKKHhyAe5/DpAcEnNynaIaLkGPmeYpnf6LbXJLNSmLgy6fryllDX1QasB4Q
	blM4fKTSRm8qMutdFchGO7WD0uVeCE4PcsF/HuLR3XzDnbjKMAECaAwktuj/PXCob44L6XA8aN4
	IlVlo+y81bM9Tmp6ggFreTRBWbj+sq+EGFue3MjI9mVgSBga55XY+fQBTmNokB05D3FCLxggN0A
	Idc0cXee8cfXQSg6oZgIprldk3apUQcgKzAVfIl4epVfcDAWNGWjqf4/JadtAPiz0fP4zz2oK1H
	eVvUHfCuYolcSrctzE9TYSSnog==
X-Google-Smtp-Source: AGHT+IEfLYzmNODztxVvFiPDO2+o7430rqr7hwRd6ybZpv/uNbd1KGgopefy3az5tEpJM3Gs6JGfxTwegveOwK8fEek=
X-Received: by 2002:a05:6214:2582:b0:873:af59:fafa with SMTP id
 6a1803df08f44-89084257243mr154924966d6.45.1767996811023; Fri, 09 Jan 2026
 14:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: mjnowen@gmail.com
From: Mike Owen <mjnowen@gmail.com>
Date: Fri, 9 Jan 2026 22:13:19 +0000
X-Gm-Features: AZwV_QhET0tDQI7BExuRllplJkfzeLC0EASvbAwLoPcKSNbn5AnTmtdr_qpYdDc
Message-ID: <CADFF-zepeLopnvw6UoBGLgxmOHMY4z_Z1OFa2Q1SBZLvni--Vw@mail.gmail.com>
Subject: NFS client hangs from NFS/fscache re-export servers
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We are seeing occasional NFS client hangs from NFS/fscache re-export servers.

The setup is in a remote location using NFS re-exporting with fscache
in a 'fan out' or 'daisy-chain' mode.

i.e. In a remote location, a single ('tier1') server is NFS mounting
shares using fscache from on-prem filers (Isilon and NetApp) and
re-exporting the shares. A small number of 'tier2' servers are
mounting the re-exported shares using fscache from the tier1 server
and re-exporting those mounts to a number of clients. We have 1x tier1
server and 5x tier2 servers and about 125+ clients per tier2 server.

The NFS re-export servers are running Ubuntu 24.04 with a
6.14.0-36-generic kernel with 256 nfsd threads using nconnect=16 for
NFS mounts.

The tier1 server is mounting the on-prem filers over NFSv3.

The tier2 servers are mounting the tier1 server over NFSv4.2.

The clients are running AlmaLinux 9.6 and mounting the tier2 servers
over NFSv4.2 using nconnect=1

The issue we have is that a small number of the NFS clients will hang
on the mounts from their tier2 server - this happens at different
times and with clients using different tier2 servers. Other clients of
the server are not affected.

Nothing is logged on the client or server when this happens - i.e. no
'NFS server not responding' or similar messages etc.

Also, there is no network traffic between the client and server when
the client gets into this state - by the time the client is flagged as
being in this state, there is no NFS socket to the server.

However, it is possible to 'unwedge' the client by running 'umount -f'
of the first NFS mounted share - the umount reports 'device is busy' -
but it has the side effect of kicking things back into life again ...
an NFS socket is created to the NFS server and traffic starts flowing.

Any ideas on what is happening here - and how it may be fixed or
suggestions for further steps to debug this issue?

Thanks,
-Mike

