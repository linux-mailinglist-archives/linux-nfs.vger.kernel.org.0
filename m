Return-Path: <linux-nfs+bounces-5006-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA55938FCB
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 15:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2AA1F21912
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 13:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F3016C445;
	Mon, 22 Jul 2024 13:18:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3101816938C
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721654318; cv=none; b=P67H3SxP0dwxgiIVYfck86KeP9Qzce0BXi4zNAFUdi8zOVPL9ZKvLQRdJ+3ur1SwY9ZrYNThZMCFHuCNYDAXVCdx46s1IYL/mk53U2tT5zo5nA/7reM+SflO8sQ3Mba3v83uJ2kXG8xcwwwqw3bRaaCD5jFs3rqCC0JwE87rJXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721654318; c=relaxed/simple;
	bh=r9f79V++8uprC9Zrq3Miao3D8CJrb6MDpuVPRTJ3We4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=RkvWQMkQbo+tuejNaACvvLYneXHZn6xz9fhLqIGg5iFQXwNoHtqgq6dg6bBdCI5kQc6nE3uIA7p11SJTokWekEix2VZKw5v1HoViXwjYf2I8JJZl+onjUWga2rePNLubEuugage0rAc8cz8PkV8YdWdBN3v3fh2K1SXnhmG2YU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CD11E61E5FE05;
	Mon, 22 Jul 2024 15:18:19 +0200 (CEST)
Message-ID: <92cfc598-d81c-4c2f-b8c6-3d2ab589fe18@molgen.mpg.de>
Date: Mon, 22 Jul 2024 15:18:19 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-nfs@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: systemd/nfs-server.service: Is `ExecStopPost=/usr/sbin/exportfs -au`
 necessary?
Cc: Steve Dickson <steved@redhat.com>, it+linux-nfs@molgen.mpg.de
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear NFS folks,


Since the beginning in 2014 with commit 929aaa7eeab1 (Added 
systemd/nfs-server.service) the systemd service unit 
`systemd/nfs-server.service` has

     Description=NFS server and services
     […]
     [Service]
     Type=oneshot
     RemainAfterExit=yes
     ExecStartPre=-/usr/sbin/exportfs -r
     ExecStart=/usr/sbin/rpc.nfsd
     ExecStop=/usr/sbin/rpc.nfsd 0
     ExecStopPost=/usr/sbin/exportfs -au
     ExecStopPost=/usr/sbin/exportfs -f

and this is still present today as of commit b76dbaa48f7c (exports(5): 
update and correct information about subdirectory exports) [1].

Is flushing out the kernel’s export table with `exportfs -au` really 
necessary when stopping the NFS server?


Kind regards,

Paul


[1]: 
https://git.linux-nfs.org/?p=steved/nfs-utils.git;a=blob;f=systemd/nfs-server.service;h=ac17d5286d3bf93d693fea5554eb439425f6857c;hb=b76dbaa48f7c239accb0c2d1e1d51ddd73f4d6be

