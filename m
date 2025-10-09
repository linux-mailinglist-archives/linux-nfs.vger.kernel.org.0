Return-Path: <linux-nfs+bounces-15106-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B944BCAB95
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 21:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1812A4E2CB1
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 19:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55B37082D;
	Thu,  9 Oct 2025 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3MRzl00"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6DB34BA59
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760039215; cv=none; b=QtJKIIQh0FQfASQ7LSMvl2Rox/DgeMTsjbVP8lwlAqs3PtgklCLHTqt7l1DSO+dx+j52SrOmT8/IMZPgQjkDr0A+JvFVxDJVtu/RJmVB48oGFJyvfuGZAIyADISPDT48VWh+kHcZS/A9KnFetohY2jIZ/pdFl/ThKAgqrgJlH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760039215; c=relaxed/simple;
	bh=wmmdY4aUVgZcUYQD257U739zhpmDF3d2z4kqZIon9Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaghJcpp64C7Z9gWEjlTK5QLT9ee+1sWWHvcDn80FHU7mQkecNJSANklEVX4uYpX3Fdn6XQ8swKAu/NXrJQiP+7CQk08CEIkPEInuiJtYp+Ebv6z228JjgtrN68aMltzK7MyrxOYJkcl/VcwMHumNNdoZC6HT4DhGghssTee6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3MRzl00; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760039212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uaxbw98cWkGBeqtG/QSs1s94iyTnnu7mckbEuZ5d2X0=;
	b=G3MRzl00ZaLfK5ttmAlDaSTIvPF6f5DF8ygsPw61f2nGg1I1AQ4xJe3YY1ceJiVsOAtJME
	doW4Ozm8BJrIbrFl+ROnYWCGrzvPOKPGV4f5MtyujBVx/CQvpu4Txn7RTEFx8yFCQ3xvKC
	qPARFDIS443F6JHYzjbMJHCNro8Zm8E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-kuDwslXrMOKioqIplUiTLA-1; Thu,
 09 Oct 2025 15:46:49 -0400
X-MC-Unique: kuDwslXrMOKioqIplUiTLA-1
X-Mimecast-MFC-AGG-ID: kuDwslXrMOKioqIplUiTLA_1760039204
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D6161956055;
	Thu,  9 Oct 2025 19:46:44 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.65.202])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 890771800576;
	Thu,  9 Oct 2025 19:46:42 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
 okorniev@redhat.com, tom@talpey.com, hch@infradead.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: Fix SCSI reservation conflict causing pNFS
 client to revert I/O to MDS
Date: Thu, 09 Oct 2025 15:46:40 -0400
Message-ID: <C3EE031E-F587-41B1-8ECA-A29B56AA6764@redhat.com>
In-Reply-To: <2cbf10c7-d434-4490-9e1a-8455e004d595@oracle.com>
References: <1759249728-29182-1-git-send-email-dai.ngo@oracle.com>
 <475D1227-CB10-461D-9EC1-A303B74A701E@redhat.com>
 <ddcea773-3d9a-47d0-b857-087655b2ec13@oracle.com>
 <AFF0E6AD-F593-4CCE-89E3-AA72E1650D99@redhat.com>
 <c0dced8a-29d1-4b5c-9fe6-47d065aa7255@oracle.com>
 <ddb63ff3-80cc-40b1-8e8e-f61575e85828@oracle.com>
 <B3F0921A-C9FE-462E-B3E2-D8D0E6B3521E@redhat.com>
 <2cbf10c7-d434-4490-9e1a-8455e004d595@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 9 Oct 2025, at 13:43, Dai Ngo wrote:

> On 10/7/25 1:37 PM, Benjamin Coddington wrote:
>> On 7 Oct 2025, at 11:59, Dai Ngo wrote:
>>
>>> On 10/1/25 10:36 AM, Dai Ngo wrote:
>>>> On 10/1/25 3:54 AM, Benjamin Coddington wrote:
>>>>> On 30 Sep 2025, at 17:41, Dai Ngo wrote:
>>>>>
>>>>>> Hi Ben,
>>>>>>
>>>>>> On 9/30/25 12:15 PM, Benjamin Coddington wrote:
>>>>>>> Hi Dai,
>>>>>>>
>>>>>>> On 30 Sep 2025, at 12:28, Dai Ngo wrote:
>>>>>>>
>>>>>>>> When servicing the GETDEVICEINFO call from an NFS client, the NF=
S server
>>>>>>>> creates a SCSI persistent reservation on the target device using=
 the
>>>>>>>> reservation type PR_EXCLUSIVE_ACCESS_REG_ONLY. This setting rest=
ricts
>>>>>>>> device access so that only hosts registered with a reservation k=
ey can
>>>>>>>> perform read or write operations. Any unregistered initiator is =
completely
>>>>>>>> blocked, including standard SCSI commands such as READCAPACITY.
>>>>>>> SBC-4, table 13 shows that READ CAPACITY should be allowed from a=
ny I_T
>>>>>>> nexus, no matter the state of the reservation on the LU.
>>>>>>>
>>>>>>> Is it possible that your SCSI implementation might be out of the =
spec?=C2=A0 Also
>>>>>>> possible that SBC-4 has been updated, I haven't been following th=
e SCSI
>>>>>>> specification updates..
>>>>>>>
>>>>>>> Ben
>>>>>> I don't have access to SBC-4 spec, t10.org does not allow guest ac=
cess
>>>>>> to their docs. Can you please share the content of table 13 here?
>>>>> The document's licensing prohibits me from doing this, I'm sorry to=
 report.
>>>>> I have a single-user copy that prohibits me from copying or transmi=
tting any
>>>>> part or whole.=C2=A0 Looks like you can get SBC-5 from the ANSI web=
store for $60:
>>>>>
>>>>> https://urldefense.com/v3/__https://webstore.ansi.org/standards/inc=
its/incits5712025__;!!ACWV5N9M2RV99hQ!N4FtetrpMVBPf88WPTlz6EuwsK0kPhNqw04=
MXvtXGUwMzzAf0NPkCYhL5HYx32ZZVogW2MKS0Jr8P8M$
>>>>>
>>>>> The reason your patch caught my eye was because we'd previously fix=
ed the
>>>>> same problem in the SCSI LIO target.
>>>> Thank you Ben, I'll get the spec from the ANSI webstore.
>>> You're right Ben! The SBC-4 spec says read capacity is allowed in thi=
s
>>> case.
>>>
>>> The problem was caused by the DS was running an older version of the
>>> kernel that did not have your fix:
>>>
>>> 28c58f8a0947f scsi: target: Enable READ CAPACITY for PR EARO
>>>
>>> This fix did not include the SERVICE_ACTION_IN_16 with Service Action=

>>> READ_CAPACITY. However, the Linux client tries SERVICE_ACTION_IN_16
>>> three times then switches to READ CAPACITY (0x25).
>>>
>>> Thank you for pointing this out.
>> Would you be willing to test this patch for SERVICE_ACTION_IN_16?
>>
>>  From d7fa5d5f593dcfe39b7456dd6f23eb042fb2636f Mon Sep 17 00:00:00 200=
1
>> Message-ID: <d7fa5d5f593dcfe39b7456dd6f23eb042fb2636f.1759869410.git.b=
codding@redhat.com>
>> From: Benjamin Coddington <bcodding@redhat.com>
>> Date: Tue, 7 Oct 2025 16:34:37 -0400
>> Subject: [PATCH] scsi: target: Fixup two more cases for PR EARO
>>
>> Allow READ_CAPACITY_16 and REPORT_REFERALS for SERVICE_ACTION_IN_16
>> in the SCSI target driver.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>>   drivers/target/target_core_pr.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_c=
ore_pr.c
>> index 83e172c92238..0b6803754422 100644
>> --- a/drivers/target/target_core_pr.c
>> +++ b/drivers/target/target_core_pr.c
>> @@ -465,6 +465,13 @@ static int core_scsi3_pr_seq_non_holder(struct se=
_cmd *cmd, u32 pr_reg_type,
>>                          return -EINVAL;
>>                  }
>>                  break;
>> +       case SERVICE_ACTION_IN_16:
>> +               switch (cdb[1] & 0x1f) {
>> +               case SAI_READ_CAPACITY_16:
>> +               case SAI_REPORT_REFERRALS:
>> +                       ret =3D 0;
>> +               }
>> +               break;
>>          case ACCESS_CONTROL_IN:
>>          case ACCESS_CONTROL_OUT:
>>          case INQUIRY:
>
> The patch worked fine for READ_CAPACITY_16.
>
> The REPORT_REFERRALS got a Check Condition with sense code 0x2000
> (Invalid command Operation code), whether there is a PR or not,
> because the SCSI target does not support Referrals as reported by
> 'sg_vpd' command.
>
> Thanks for doing this, Ben.
>
> -Dai

Thanks for the test.  I'll send this to the target list, and will add you=
r
Tested-by unless you'd rather it withheld.

Ben


