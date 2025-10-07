Return-Path: <linux-nfs+bounces-15038-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC48BC2A8F
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 22:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB4B19A2146
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 20:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAA4221FB4;
	Tue,  7 Oct 2025 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ke1gYlf3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AAD1D90AD
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869494; cv=none; b=M3JFh/8e9wXfapE1L+sOImiMOhJfi1QXLuBcCT5TiApUcqRYpaWX9PVJt3YXqOrvNbEiaHUULMNvn9+d1ZDZn4uom1bji/LsxT5h2tsrrXFo7khBf+1zONBN7rM/l8Cn/t0m0fI286e2XuKpJhr4xwVyW64H4fUGWN873gM2sZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869494; c=relaxed/simple;
	bh=xML2AoDvVP+tA3vh0FhxnWvKYr7xVWy84NCdGRRZDUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liGdHTRhQmdm7rzrRIwPL0GIgSAqAjZiuIWQjUpkdDiJH6rinXt2+N7wdGyggyirTiKED5SLB5jei1ZDea25ttVN1JxbYkHVWbV+IjL9kN0/uB4ZO8rB0PCyapQ8D/AcmNSJtRzD++IA7t2Dh8gx/lcgcdx50YOq2xzFi4PiPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ke1gYlf3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759869489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLNCYVXUdMiYtdSC2ccXAZg2SFKMDQ4vqND14i5ygsc=;
	b=Ke1gYlf3FkZGDRImQQz1g0L8/+T3bASYhQpinVfoQAw3JJnVF2sjvh0Opj6FplIFid6lSj
	6gUqv6FoLbITXsA/X8u2R/SHWpssLlvpoQzMAkUS8d1DXMjE/wG5fXIwmpekNViFI3Zlhq
	QebEXUA7kr+BrynWQgmN76gE1pdztLA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-8HqDLKKGNOSqBeBeChqpJQ-1; Tue,
 07 Oct 2025 16:38:05 -0400
X-MC-Unique: 8HqDLKKGNOSqBeBeChqpJQ-1
X-Mimecast-MFC-AGG-ID: 8HqDLKKGNOSqBeBeChqpJQ_1759869484
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3353E1800605;
	Tue,  7 Oct 2025 20:38:01 +0000 (UTC)
Received: from [10.22.81.72] (unknown [10.22.81.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFA8119540EB;
	Tue,  7 Oct 2025 20:37:59 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
 okorniev@redhat.com, tom@talpey.com, hch@infradead.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: Fix SCSI reservation conflict causing pNFS
 client to revert I/O to MDS
Date: Tue, 07 Oct 2025 16:37:58 -0400
Message-ID: <B3F0921A-C9FE-462E-B3E2-D8D0E6B3521E@redhat.com>
In-Reply-To: <ddb63ff3-80cc-40b1-8e8e-f61575e85828@oracle.com>
References: <1759249728-29182-1-git-send-email-dai.ngo@oracle.com>
 <475D1227-CB10-461D-9EC1-A303B74A701E@redhat.com>
 <ddcea773-3d9a-47d0-b857-087655b2ec13@oracle.com>
 <AFF0E6AD-F593-4CCE-89E3-AA72E1650D99@redhat.com>
 <c0dced8a-29d1-4b5c-9fe6-47d065aa7255@oracle.com>
 <ddb63ff3-80cc-40b1-8e8e-f61575e85828@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 7 Oct 2025, at 11:59, Dai Ngo wrote:

> On 10/1/25 10:36 AM, Dai Ngo wrote:
>>
>> On 10/1/25 3:54 AM, Benjamin Coddington wrote:
>>> On 30 Sep 2025, at 17:41, Dai Ngo wrote:
>>>
>>>> Hi Ben,
>>>>
>>>> On 9/30/25 12:15 PM, Benjamin Coddington wrote:
>>>>> Hi Dai,
>>>>>
>>>>> On 30 Sep 2025, at 12:28, Dai Ngo wrote:
>>>>>
>>>>>> When servicing the GETDEVICEINFO call from an NFS client, the NFS =
server
>>>>>> creates a SCSI persistent reservation on the target device using t=
he
>>>>>> reservation type PR_EXCLUSIVE_ACCESS_REG_ONLY. This setting restri=
cts
>>>>>> device access so that only hosts registered with a reservation key=
 can
>>>>>> perform read or write operations. Any unregistered initiator is co=
mpletely
>>>>>> blocked, including standard SCSI commands such as READCAPACITY.
>>>>> SBC-4, table 13 shows that READ CAPACITY should be allowed from any=
 I_T
>>>>> nexus, no matter the state of the reservation on the LU.
>>>>>
>>>>> Is it possible that your SCSI implementation might be out of the sp=
ec?=C2=A0 Also
>>>>> possible that SBC-4 has been updated, I haven't been following the =
SCSI
>>>>> specification updates..
>>>>>
>>>>> Ben
>>>> I don't have access to SBC-4 spec, t10.org does not allow guest acce=
ss
>>>> to their docs. Can you please share the content of table 13 here?
>>> The document's licensing prohibits me from doing this, I'm sorry to r=
eport.
>>> I have a single-user copy that prohibits me from copying or transmitt=
ing any
>>> part or whole.=C2=A0 Looks like you can get SBC-5 from the ANSI webst=
ore for $60:
>>>
>>> https://urldefense.com/v3/__https://webstore.ansi.org/standards/incit=
s/incits5712025__;!!ACWV5N9M2RV99hQ!N4FtetrpMVBPf88WPTlz6EuwsK0kPhNqw04MX=
vtXGUwMzzAf0NPkCYhL5HYx32ZZVogW2MKS0Jr8P8M$
>>>
>>> The reason your patch caught my eye was because we'd previously fixed=
 the
>>> same problem in the SCSI LIO target.
>>
>> Thank you Ben, I'll get the spec from the ANSI webstore.
>
> You're right Ben! The SBC-4 spec says read capacity is allowed in this
> case.
>
> The problem was caused by the DS was running an older version of the
> kernel that did not have your fix:
>
> 28c58f8a0947f scsi: target: Enable READ CAPACITY for PR EARO
>
> This fix did not include the SERVICE_ACTION_IN_16 with Service Action
> READ_CAPACITY. However, the Linux client tries SERVICE_ACTION_IN_16
> three times then switches to READ CAPACITY (0x25).
>
> Thank you for pointing this out.

Would you be willing to test this patch for SERVICE_ACTION_IN_16?

=46rom d7fa5d5f593dcfe39b7456dd6f23eb042fb2636f Mon Sep 17 00:00:00 2001
Message-ID: <d7fa5d5f593dcfe39b7456dd6f23eb042fb2636f.1759869410.git.bcod=
ding@redhat.com>
From: Benjamin Coddington <bcodding@redhat.com>
Date: Tue, 7 Oct 2025 16:34:37 -0400
Subject: [PATCH] scsi: target: Fixup two more cases for PR EARO

Allow READ_CAPACITY_16 and REPORT_REFERALS for SERVICE_ACTION_IN_16
in the SCSI target driver.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 drivers/target/target_core_pr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core=
_pr.c
index 83e172c92238..0b6803754422 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -465,6 +465,13 @@ static int core_scsi3_pr_seq_non_holder(struct se_cm=
d *cmd, u32 pr_reg_type,
                        return -EINVAL;
                }
                break;
+       case SERVICE_ACTION_IN_16:
+               switch (cdb[1] & 0x1f) {
+               case SAI_READ_CAPACITY_16:
+               case SAI_REPORT_REFERRALS:
+                       ret =3D 0;
+               }
+               break;
        case ACCESS_CONTROL_IN:
        case ACCESS_CONTROL_OUT:
        case INQUIRY:
-- =

2.50.1


