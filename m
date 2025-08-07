Return-Path: <linux-nfs+bounces-13472-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E576B1D9E9
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 16:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6CD3AABB9
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 14:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E49227EA7;
	Thu,  7 Aug 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jq81wjxO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152172B2DA
	for <linux-nfs@vger.kernel.org>; Thu,  7 Aug 2025 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754576729; cv=none; b=hTommvP4rqeInRDqaLzFmI7JIsVDlVyrWcp0ljMJkiRtbBZZyHYl8baxoivvNYQwyVYOAx/kLuBiF6rYYL/o2ZgeX2NIkJ69EuLyrLlxwD7/azz9IG0TCITGVbtQrt/rlYgaRIqdWe/YganG5xP7nIEXk5U/yzLHnfge9+ibP7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754576729; c=relaxed/simple;
	bh=5FfS9RrA6ljLuFZtCZkqaONZdg0aDwdxl9IfdRWK0tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrhwDoqMihiMAjHYT2W1eGMd2c7AHyqxS1WSu9FgrB24G9/nVWG/K1SvNO0puZMn14ucLIDqX/Tj/s52M8v9unNJ8Yh9xL0La7Tf5gc4uKxtZk0Zgy1JcmYFGFuj6eQrhQpyh43O7LmBnOMKHQevfCsIO+6PjCI2zs7UN7X76bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jq81wjxO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754576727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Id2Z7IBoQLq5LQ+fog/qeYS32cc/0250as+C33yYAow=;
	b=Jq81wjxOVHJs101R4Ii/Qs1HuhwDLZgndy3LQTQssuT403fuKo5EPLPED8rjQlDRW9vqtQ
	P+gs0WsWo5kREUf59+Jd6OFNTAssOFWJSzy5OEeKLihhHH57+aXaFghNE/n8MxCXHORfCO
	yWSbwzSs7EuGcyPoPEtQbbpFdJZ+Yhk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-wmzQBvQtPHCJQJ9ALzhW4A-1; Thu,
 07 Aug 2025 10:25:22 -0400
X-MC-Unique: wmzQBvQtPHCJQJ9ALzhW4A-1
X-Mimecast-MFC-AGG-ID: wmzQBvQtPHCJQJ9ALzhW4A_1754576722
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08D1119560B6;
	Thu,  7 Aug 2025 14:25:22 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.50])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B73351800285;
	Thu,  7 Aug 2025 14:25:21 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id D03E935F5A8; Thu, 07 Aug 2025 10:25:19 -0400 (EDT)
Date: Thu, 7 Aug 2025 10:25:19 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: John <therealgraysky@proton.me>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Missing pipe /var/lib/nfs/rpc_pipefs/nfsd/cld on OpenWrt
Message-ID: <aJS3TwTldSYi8y9g@aion>
References: <Pm2hmCTqzxzgnGtJpzqYHI5uV7Z7oQjykswavqCewEF_9wqXOJo3_EXS76gIzkpfu9eJLSDlKgNwJrNmTWgD2vKSEr3kLyDsr_Fzzj6jRYs=@proton.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pm2hmCTqzxzgnGtJpzqYHI5uV7Z7oQjykswavqCewEF_9wqXOJo3_EXS76gIzkpfu9eJLSDlKgNwJrNmTWgD2vKSEr3kLyDsr_Fzzj6jRYs=@proton.me>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, 02 Aug 2025, John wrote:

> I want to modify the nfs-kernel-server package to use nfsdcld for client tracking, but am hitting a snag: I can't figure out why the pipe /var/lib/nfs/rpc_pipefs/nfsd/cld is missing or what creates it.
> 
> Here is my current version: https://github.com/graysky2/packages/commit/c68d0ca16b3b69a0ffcad3dbb20bad58ee49a638
> 
> I have the lines in the init script to start /usr/sbin/nfsdcld commented out so it can be run manually with the debug option on the shell to see why it fails. What creates the pipe /var/lib/nfs/rpc_pipefs/nfsd/cld and why is it not doing so is the questions I cannot answer. Any insights are appreciated.
> 
> # nfsdcld -F -d
> nfsdcld: sqlite_startup_query_grace: current_epoch=1 recovery_epoch=0
> nfsdcld: sqlite_check_db_health: returning 0
> nfsdcld: sqlite_copy_cltrack_records: returning -1
> nfsdcld: sqlite_prepare_dbh: num_cltrack_records = 0
> 
> nfsdcld: sqlite_prepare_dbh: num_legacy_records = 0
> 
> nfsdcld: cld_pipe_init: init pipe handlers
> nfsdcld: cld_pipe_open: opening upcall pipe /var/lib/nfs/rpc_pipefs/nfsd/cld
> nfsdcld: cld_pipe_open: open of /var/lib/nfs/rpc_pipefs/nfsd/cld failed: No such file or directory
> nfsdcld: main: Starting event dispatch handler.
> 

It gets created when nfsd starts up (see nfsd4_cld_register_sb() in
fs/nfsd/nfs4recover.c).  At that point you should see nfsdcld get an
inotify event, open the cld file, and continue doing its thing.

-Scott


