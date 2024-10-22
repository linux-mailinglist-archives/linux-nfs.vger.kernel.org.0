Return-Path: <linux-nfs+bounces-7350-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A42E9A9736
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 05:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A398B21645
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 03:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC3478B60;
	Tue, 22 Oct 2024 03:42:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from nucleus.ldx.ca (nucleus.ldx.ca [192.234.197.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1650E256D
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 03:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.234.197.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568547; cv=none; b=qEiZBIPnSkcs6k5aX7oyP5jNAJlNXJpGHLDMB2iOZ4S2/7Kuz5jESdcZNQL5ObMN+govuT4E8J+NPYQAZJefs+fEOsIhicso3N+iP7kQgLDSZsDvZ6Lmv/Fli3tVDdZgeW48QJ7BsyvDf/yO0rM60TySRoNDCFHcJl8dhzLwV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568547; c=relaxed/simple;
	bh=QwxZpxIlTEFy7obvuAGjjIazG4QkdgF5ps7fZ25gNNk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LR5oNFN8S2goErJsxJO+EomggFt84l5QWJW9ixyUPc1JZhK1NEsim1jLR4LGVxFIPSskYYMrlwGmnO8vpPe6RJkeIUl7UI0f8fBiVrF6FNLVnTjRTkFwa2/mEwgbJtg0JAYpaATdBvNALQkAp5weXKeW9orIWjA69Uq5ANsnlLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ldx.ca; spf=pass smtp.mailfrom=ldx.ca; arc=none smtp.client-ip=192.234.197.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ldx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ldx.ca
Received: by nucleus.ldx.ca (Postfix, from userid 1000)
	id 79DE95F743; Mon, 21 Oct 2024 20:42:24 -0700 (PDT)
Date: Mon, 21 Oct 2024 20:42:24 -0700
From: Tyler Mitchell <fission@ldx.ca>
To: linux-nfs@vger.kernel.org
Subject: /proc/fs/nfsd/clients/*/info TCP port not updating after reconnect
Message-ID: <20241022034224.GE2515022@ldx.ca>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have an NFS server running on Alpine Linux:

# uname -a
Linux charm 6.6.54-0-lts #1-Alpine SMP PREEMPT_DYNAMIC 2024-10-04 16:47:58 x86_64 Linux

I wrote some very simple shell scripts to track & report NFS client
usage. But I noticed that after some time, the TCP port reported in
the "address" field of /proc/fs/nfsd/clients/*/info doesn't match
the actual TCP port in use by the client.

An example from the server side:

# cat /proc/fs/nfsd/clients/4/info
clientid: 0xdf43354e670522ab
address: "192.168.93.218:752"
status: confirmed
seconds from last renew: 60
name: "Linux NFSv4.2 raspberrypi"
minor version: 2
Implementation domain: "kernel.org"
Implementation name: "Linux 6.1.21-v7+ #1642 SMP Mon Apr  3 17:20:52 BST 2023 armv7l"
Implementation time: [0, 0]
callback state: UP
callback address: 192.168.93.218:0
# netstat -n | egrep '(Foreign|:2049)'
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 192.168.93.82:2049      192.168.93.218:776      ESTABLISHED
tcp        0      0 192.168.93.82:2049      192.168.93.218:752      ESTABLISHED

And on the client:

% netstat -4n
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 192.168.93.218:776      192.168.93.82:2049      ESTABLISHED


When the NFS connection was first established, it was using 752 (I
had checked), but it seems that it got disconnected at some point
and reconnected from port 776. (In this case I was actually doing
some rewiring and the NFS server was temporarily disconnected from
the network.)

The client_info_show() function seems to be just reading the state
data from a struct nfs4_client. And I see this gets populated in
create_client() but I don't see it being updated anywhere. In this
case, it would have to happen after the client reconnects following
a transient error.

Anyhow, I don't have an immediate solution, but wanted to mention
this in case it wasn't already a known issue. Ideally the port
could be updated when it changes so that it's possible to better
track active clients.

Many thanks,
Tyler

