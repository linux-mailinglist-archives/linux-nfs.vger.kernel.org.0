Return-Path: <linux-nfs+bounces-7907-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533BB9C5B7F
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 16:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02ADEB3EE26
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 15:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E448E20012B;
	Tue, 12 Nov 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivTvHSlS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F95171671
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423564; cv=none; b=VsCPvMuocbhyetKzvoidLCrJb7gTPIAOWU6872TZbr/Vzt0Epzd6to4JtK8/tW6c3KxRpudVC8pV/181960EicA2dQryjQDwC4h+gJKqj5/AsdHCTSxZdnzhHdi93Uv8NKVNSSYQzC90HbRfojJmgoeU0qkZp2t5nfTNjf+2Dm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423564; c=relaxed/simple;
	bh=FSm9cgnryQuFOUnZLa6fOiIOmrbbxcCg0Dr93Ll2E0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCKrqqiiuk0IUpEDU3qs8rxLZzA+pGj9rgeyPxUU55HuXvSkGyB82R7jsBkjXmurXuStmd3XpDezRMgAnqJIPrmy6pMrY2Ivaf8WlZzB6p6Yw0pREhSzd6XCQaZIpjclcR+eyrL83V8lhLyuW0g934fu2tYOS3ltWiFZXIYUEl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivTvHSlS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731423562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAN9oAM8ZIGherOh2Xke+jMbU6MPDtwmaX+TCGofDmE=;
	b=ivTvHSlSGeREjjdEtZFjsHMBncD0RWLAa8fGnfpviSkqDdSZIGDQIWk8AnOfRtdPcAbSVm
	Y9/x5Fi8vUecDkQ6hf+c9e9R8+iPo8w51DBQfcueyWyXk0EhCWla07B/QCrsbkW14IT5fD
	4xHCLe8DMzLQGGTKtNesjhiOFw3dY84=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-bWj8hvu7OGGmILVGmJvjdQ-1; Tue,
 12 Nov 2024 09:59:18 -0500
X-MC-Unique: bWj8hvu7OGGmILVGmJvjdQ-1
X-Mimecast-MFC-AGG-ID: bWj8hvu7OGGmILVGmJvjdQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED15F1955F08;
	Tue, 12 Nov 2024 14:59:17 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.7])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B4E71956086;
	Tue, 12 Nov 2024 14:59:17 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Philip Rowlands <linux-nfs@dimebar.com>, linux-nfs@vger.kernel.org
Subject: Re: Insecure hostname in nsm_make_temp_pathname
Date: Tue, 12 Nov 2024 09:59:15 -0500
Message-ID: <F18AA886-F024-49A6-8FFC-F35A6A923704@redhat.com>
In-Reply-To: <ZzNpGZ1mK8lUo4St@tissot.1015granger.net>
References: <6296a7d4-64de-4df0-893e-8895e8ec36d0@app.fastmail.com>
 <192D38BE-BC46-4C8F-8C01-89EED779E77B@redhat.com>
 <ZzNpGZ1mK8lUo4St@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 12 Nov 2024, at 9:41, Chuck Lever wrote:

> On Tue, Nov 12, 2024 at 09:27:45AM -0500, Benjamin Coddington wrote:
>> On 11 Nov 2024, at 17:49, Philip Rowlands wrote:
>>
>>> If a host dies after nsm_make_temp_pathname but before rename(temp, p=
ath) we may be left with paths resembling .../server.example.com.new
>>>
>>> Some clever person has registered and installed a wildcard DNS record=
 for *.com.new.
>>>
>>> $ host server.example.com.new
>>> server.example.com.new has address 104.21.68.132
>>> server.example.com.new has address 172.67.195.202
>>>
>>> You can see where this is going...
>>>
>>> Our firewall scanners tripped on outbound access to this address, por=
t 111, I assume due to NSM reboot notifications.
>>>
>>> Suggested workarounds include:
>>> * explicitly skip over paths matching the expect tempname pattern in =
nsm_load_dir()
>>> * use a different tmp suffix than .new, e.g. one which won't work in =
DNS
>>>
>>> Steps to reproduce:
>>>
>>> # cat /var/lib/nfs/statd/sm/server.example.com.new
>>> 0100007f 000186b5 00000003 00000010 89ae3382e989d91800000000dc00ed000=
000ffff 1.2.3.4 my-client-name
>>> # sm-notify -d -f -n
>>> sm-notify: Version 2.7.1 starting
>>> sm-notify: Retired record for mon_name server.example.com.new
>>> sm-notify: Added host server.example.com.new to notify list
>>> sm-notify: Initializing NSM state
>>> sm-notify: Failed to open /proc/sys/fs/nfs/nsm_local_state: No such f=
ile or directory
>>> sm-notify: Effective UID, GID: 29, 29
>>> sm-notify: Sending PMAP_GETPORT for 100024, 1, udp
>>> sm-notify: Added host server.example.com.new to notify list
>>> sm-notify: Host server.example.com.new due in 2 seconds
>>> sm-notify: Sending PMAP_GETPORT for 100024, 1, udp
>>> # etc.
>>>
>>> tcpdump shows the outbound traffic:
>>> 22:42:31.940208 IP 192.168.0.131.819 > 172.67.195.202.sunrpc: UDP, le=
ngth 56
>>> 22:42:33.942440 IP 192.168.0.131.819 > 172.67.195.202.sunrpc: UDP, le=
ngth 56
>>> 22:42:37.946903 IP 192.168.0.131.819 > 172.67.195.202.sunrpc: UDP, le=
ngth 56
>>>
>>> The client statd was artificially placed for the purposes of showing =
the problem, but I hope it's close enough to make sense.
>>
>> Makes sense.. yikes!
>>
>> Maybe we could just prepend '.' since nsm_load_dir() ignores those - C=
huck, you were in here last any thoughts?
>
> The problem with a leading dot is, of course, the file becomes
> hidden, which might be surprising to administrators who are trying
> to diagnose a problem.

I used to be one of those, and would say this isn't a big issue for any
competent admin.  It has another advantage of also never being a valid DN=
S
name because it has an "empty label".

> Note that a domain label can contain only the letters A-Z (or a-z),
> the digits 0-9, hyphen (-), and dot (.). So replace ".new" with
> something that contains an invalid character like ".<new>"

Hmm.. I thought (goes to dig it up) that any binary string can serve as a=

name representation.  https://datatracker.ietf.org/doc/html/rfc2181#secti=
on-11

=2E.that's been updated by a number of other RFCs.. (gah! - case insensit=
ive
comparisons!)  I admit to not knowing or wanting to keep digging through =
RFCs
for the current domain label specification.  Do you have a current refere=
nce
and feel like we can depend on it?

Thanks for chiming in here!

Ben


