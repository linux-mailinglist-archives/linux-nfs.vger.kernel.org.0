Return-Path: <linux-nfs+bounces-10739-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C2AA6BD32
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 15:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690F8189E652
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 14:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7C11CBEB9;
	Fri, 21 Mar 2025 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrdF2Run"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49B915DBBA
	for <linux-nfs@vger.kernel.org>; Fri, 21 Mar 2025 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567822; cv=none; b=PXz9GlWdrkw0RDzAY/aKkWyI+Qw5TTDLg+ASQXWcmsE3dt4DDhGjZDzDgVCRthE+aEQIsEMSCXSjNKOlS1tnoS9UAWJCIunC5dUopFwYHqkZAENhns1tx3cJonZeWN9EqcRJXWljeUF65v+Dnkrmz8Soka5DG2j9Px7k8f59ziA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567822; c=relaxed/simple;
	bh=KsB+KXqfyS0PooPCG/I2t6GXbxR6l+JANDY0T5kjLB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukQjw+ZCnKRZsd1bh+n1e8KZORR0EM/DfcSNolR13D9aU5VQd/GvAYp/v1jOsB5v0+GTeXWT2qqRa6UgA7EG1dB9LAN0C0ZW8+qc2HW5sTN6GT7Exkb3Ifq/MOwn6HgBDTJZCXiAN9h8JPbefm50oNdxzM3Am/8odCLWdctmBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NrdF2Run; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742567819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z26rPLu4zyjRysqNOaod5pTf35m2Jkkfm19QgME8UMk=;
	b=NrdF2RunOZ3QxsznI2bn75a2aIFRgHeoj3YZyDUeyelaRY6DKv+DiX0TxP1rEVERi4JFvg
	9QROt5Bg9hJJj98qNr4Ln2HIShK/gMMg+yoN8W0fQpEi9rDH925UqpGyemzUZPFVOKL6gk
	L/+ExmmTLmKA4IuVbAfndFX+FID9zCw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-2FFybyFsO_izQnXoLHkXyQ-1; Fri,
 21 Mar 2025 10:36:56 -0400
X-MC-Unique: 2FFybyFsO_izQnXoLHkXyQ-1
X-Mimecast-MFC-AGG-ID: 2FFybyFsO_izQnXoLHkXyQ_1742567815
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 091B319560AA;
	Fri, 21 Mar 2025 14:36:55 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 565851800370;
	Fri, 21 Mar 2025 14:36:53 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
 Dai Ngo <dai.ngo@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>,
 Tom Talpey <tom@talpey.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
Date: Fri, 21 Mar 2025 10:36:51 -0400
Message-ID: <0895A981-76C0-41A0-B474-62659480B31F@redhat.com>
In-Reply-To: <0750ef11-f189-4937-b893-a3edd2ef1afb@oracle.com>
References: <543f93fd-3b5a-4e4a-b2b0-0a1b7e1e8361@oracle.com>
 <174242076022.9342.12166225816627715170@noble.neil.brown.name>
 <0750ef11-f189-4937-b893-a3edd2ef1afb@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 20 Mar 2025, at 13:53, Chuck Lever wrote:

> On 3/19/25 5:46 PM, NeilBrown wrote:
>> On Thu, 20 Mar 2025, Dai Ngo wrote:
>>> Hi,
>>>
>>> Currently when the local file system needs to be unmounted for maintenance
>>> the admin needs to make sure all the NFS clients have stopped using any files
>>> on the NFS shares before the umount(8) can succeed.
>>
>> This is easily achieved with
>>   echo /path/to/filesystem > /proc/fs/nfsd/unlock_filesystem
>>
>> Do this after unexporting and before unmounting.
>
> Seems like administrators would expect that a filesystem can be
> unmounted immediately after unexporting it. Should "exportfs" be changed
> to handle this extra step under the covers? Doesn't seem like it would
> be hard to do, and I can't think of a use case where it would be
> harmful.

No. I think that admins don't expect to lose all their NFS client's state if
they're managing the exports.  That would be a really big and invisible change
to existing behavior.

Ben


