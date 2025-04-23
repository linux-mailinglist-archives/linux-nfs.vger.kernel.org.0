Return-Path: <linux-nfs+bounces-11228-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF71A985A2
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 11:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378FF168953
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 09:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116BF2701A9;
	Wed, 23 Apr 2025 09:34:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145C121FF51
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745400861; cv=none; b=CzQvbPuBEktLBv8WMJDIUAEncl68ALHZeUTXK3M6kKC7j7+mYHfP2V41b9BAe7PWukjK0ujaIdd8ZT60UrbaOWwh+5GVb3SKKLMul3YkL77+EgxgJyL6xAW4dhHr1ZpEYOeZprP+0HTpa+I5czPy+2jqziUwCGAXdVmfQou6Iqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745400861; c=relaxed/simple;
	bh=4EfD/+Z8Xf6l9kPCb9B3brk6eBR09/HkW+GjwdGyNLs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:CC:
	 In-Reply-To:Content-Type; b=scfiyteI2SoQY7ehBEJ6HLbqnqlJkqjnQoacyZol3ejNahcsqjpEBNSStNpHNz/HXudlPzGc/VO9tHKatoSmHQVqi4cavYk9p/3fKfftONTAX2C/FGkmt0w/V9rgWCuGMyzPWoQEdt5AAhc5ALAr21s3cCON9GixnVNx3O+UViY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZjDTs71k6z27hV9;
	Wed, 23 Apr 2025 17:34:57 +0800 (CST)
Received: from kwepemp200004.china.huawei.com (unknown [7.202.195.99])
	by mail.maildlp.com (Postfix) with ESMTPS id BE2C21402C4;
	Wed, 23 Apr 2025 17:34:14 +0800 (CST)
Received: from [10.174.179.184] (10.174.179.184) by
 kwepemp200004.china.huawei.com (7.202.195.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Apr 2025 17:34:13 +0800
Message-ID: <1dde8c79-f895-49d9-8b64-057e4d72bb68@huawei.com>
Date: Wed, 23 Apr 2025 17:34:12 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: a discussion on CVE-2025-2312
From: "zhangjian (CG)" <zhangjian496@huawei.com>
To: <ghudson@mit.edu>, <asn@cryptomilk.org>, <abokovoy@redhat.com>,
	<jlayton@kernel.org>, <sfrench@samba.org>, <simo@redhat.com>,
	<piastryyy@gmail.com>, <hartmans@mit.edu>, <tlyu@mit.edu>,
	<pshilov@microsoft.com>, <ronniesahlberg@gmail.com>, <nmav@redhat.com>,
	<sbose@redhat.com>
References: <CAEFhzs8xhvOVbkmnP61ottvKswjxczETVHs9ddCgs2=TEt8ipg@mail.gmail.com>
 <9b11ac6e-d279-42dc-bc46-49c0bd48566f@huawei.com>
CC: <linux-cifs-client@lists.samba.org>, <kerberos@mit.edu>,
	<linux-nfs@vger.kernel.org>, <krb5-bugs@mit.edu>, <krbcore-security@mit.edu>,
	<gss-proxy@lists.fedorahosted.org>
In-Reply-To: <9b11ac6e-d279-42dc-bc46-49c0bd48566f@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemp200004.china.huawei.com (7.202.195.99)

Hello, every exports.

CVE-2025-2312 is a CVE related to cifs, kerbose and linux kernel
modules. I think this is not really a problem. Briefly describe as this
scene:
driver pod                        | application pod
------------------------------------------------------------------------
mount cifs to /mnt                |
                                  | access /mnt but connection is down
reconnect and call cifs.upcall    |
cifs.upcall program switch to namespace of application pod
                                  |fetch cred and save in ccache
use cred to connect               |


CVE say upcall to application pod will leak sensitive data from driver
pod. I don't think this attack is right. Nobody except driver pod can
know detail about cred and I don't know how to leak sensitive data.
Is there any scene support this CVE?

Wish for response, thx.



> -------- Forwarded Message --------
> Subject: Re: Regarding service request 1841915
> Date: Mon, 7 Apr 2025 11:53:58 -0300
> From: Pedro Sampaio <psampaio@redhat.com>
> To: zhangjian (CG) <zhangjian496@huawei.com>
> 
> Hello,
> 
> I'm not familiar with that behavior for cifs.
> 
> But the point for the vulnerability in my understanding is the
> crossover of namespaces triggered from the pod's namespace. Even if
> details can be known by the pod, unintended behavior can crossover
> between namespaces.
> 
> I'm not sure if I was clear. I apologize as I'm not an expert in cifs
> or kerberos. Maybe a consultation from upstreams mailing lists is a
> better option for this discussion.
> 
> Regards,
> 
> On Thu, Apr 3, 2025 at 1:30 AM zhangjian (CG) <zhangjian496@huawei.com>
> wrote:
>>
>> Hello,
>>
>> I'm more familier with nfs, maybe there is some misunderstanding for me.
>> In nfs, if path /x is mounted on host node a, and expoted as /y in pod
>> b. Pod b who can see path /y can also access it, without caring abort
>> who created kerbose cred or where it is stored. Pod b could know no
>> details in the cred. If /x in mounted in pod b and exported to host
>> node(, just suppose it, though it couldn't happen) as /y. Then host user
>> can access it without knowing any detail in cred.
>> Only kernel and host or pod who create the cred know details about cred.
>>
>> I think user who use cifs can't know detail about cred as mentioned
>> above. Is this also valid in cifs?
>>
>> On 2025/4/2 3:17, Pedro Sampaio wrote:
>>> Hello,
>>>
>>> This is the attack scenario from the original vulnerability report,
>>> quoted in its entirety:
>>>
>>> ---
>>> "In some cases, like described below, cifs.upcall program from the
>>> cifs-utils package makes an upcall to the wrong namespace in
>>> containerized environments.
>>>
>>> Consider the following scenario:
>>> A CIFS/SMB file share is mounted on a host node using Kerberos
>>> authentication. During the session setup phase, the Linux kernel's
>>> cifs.ko module makes an upcall to user space to retrieve the Kerberos
>>> service ticket from the credential cache.
>>>
>>> In typical (non-container) environments, this process works correctly,
>>> but in containerized environments, the upcall may be directed to a
>>> different namespace than intended, leading to issues. For example:
>>>
>>> (1) The file share is mounted on the host node at /mnt/testshare1,
>>> meaning the Kerberos credential cache is stored in the host's
>>> namespace.
>>> (2) Docker container is created, and the file share path
>>> /mnt/testshare1 is exported to the container at /sharedpath.
>>> (3) When the service ticket expires and the SMB connection is lost,
>>> before the ticket is refreshed in the credential cache, an application
>>> inside the container performs a file operation. This triggers the
>>> kernel to attempt a session reconnect.
>>> (4) During the session setup, a Kerberos ticket is needed, so the
>>> kernel invokes the cifs.upcall binary using the request_key function.
>>> However, cifs.upcall switches to the namespace of the caller (i.e.,
>>> the container), causing it to attempt to read the credential cache
>>> from the container's namespace. But since the original mount happened
>>> in the host namespace, the credential cache is located on the host,
>>> not in the container. This results in the upcall failing to access the
>>> correct credential cache or accessing credential cache which doesn't
>>> belong to the correct user."
>>> ---
>>>
>>> My initial analysis concluded that the CVE assignment is still valid.
>>> A clear attack vector was presented in the original report and
>>> although the fix might seem odd, the vulnerability's existence does
>>> not depend on the type or format of the fix.
>>>
>>> The race condition between the times when the Kerberos ticket expires
>>> and the reconnect is made is a security relevant event and may lead to
>>> a leak. Even if the risk is low, that also does not influence the
>>> decision to assign a CVE ID.
>>>
>>> With that said, we are maintaining the CVE assignment at this moment.
>>>
>>> If you wish to send more evidence, we can continue this discussion.
>>> You can also appeal this decision through Mitre's Top Level Root CNA.
>>>
>>> Regards,
>>>
>>> On Tue, Apr 1, 2025 at 3:19 AM zhangjian (CG) <zhangjian496@huawei.com> wrote:
>>>>
>>>> Hello，is there any progress on this request?
>>>>
>>>> On 2025/3/28 20:03, Pedro Sampaio wrote:
>>>>> Hello,
>>>>>
>>>>> Thank you for submitting this dispute request.
>>>>>
>>>>> We'll analyze your claim and will report back as soon as an update is available.
>>>>>
>>>>> Regards,
>>>>>
>>>>> On Thu, Mar 27, 2025 at 11:14 PM 'zhangjian (CG)' via
>>>>> CNALR-Coordination@redhat.com <cnalr-coordination@redhat.com> wrote:
>>>>>>
>>>>>> Hello.
>>>>>> We have disagreements in our internal discussions for whether LTS
>>>>>> version os should introduce the fix patch for CVE-2025-2312. The key
>>>>>> point is that some committers don't think this should be tagged CVE. We
>>>>>> advice to reject CVE-2025-2312.
>>>>>> There are some reasons for rejecting it:
>>>>>>
>>>>>> 1. CVE-2025-2312 describes a case: when mount cifs in driver pod but
>>>>>> access cifs path in application pod, which pod should cifs.upcall get
>>>>>> kerbose cred from ? Or to say which namespace should send upcall to ?
>>>>>> CVE-2025-2312 think sending upcall application pod is a trouble, which
>>>>>> may leak information from application pod. But we don't think it is a
>>>>>> problem. You can also say sending upcall to driver pod may leak
>>>>>> information from driver pod.
>>>>>>
>>>>>> 2. Fix patch add a mount option CIFS.UPCALL to allow user to choose
>>>>>> whether sending upcall to driver pod or application pod. But Sending
>>>>>> upcall to application pod is still the default behavour, which infers
>>>>>> sending upcall to application pod is a normal behavour.
>>>>>>
>>>>>> 3. Adding mount option to help user choose whether fixing CVE or not is
>>>>>> odd for us.
>>>>>>
>>>>>> 4. This is more like a new feature. It can be supported in cifs-utils
>>>>>> and kernel in next release version. LTS versions os can avoid leaking by
>>>>>> designing or restricted behavour. It is unneccesory for LTS versions to
>>>>>> support new mount option.
>>>>>>
>>>>>> Thank for review. Wish for replay.
>>>>>>
>>>>>>
>>>>>> On 2025/3/28 9:20, CVE Request wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Regarding your CVE service request, logged on 2025-03-25T23:43:35, we have the following question or update:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> To update CVE-2025-2312 you must contact the assigning CNA - the Red Hat CNA-LR.
>>>>>>>
>>>>>>> https://www.cve.org/CVERecord?id=CVE-2025-2312
>>>>>>>
>>>>>>> https://www.cve.org/PartnerInformation/ListofPartners/partner/redhat
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Please do not hesitate to contact the CVE Team by replying to this email if you have any questions, or to provide more details.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Please do not change the subject line, which allows us to effectively track your request.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> CVE Assignment Team
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> M/S M300, 202 Burlington Road, Bedford, MA 01730 USA
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> [A PGP key is available for encrypted communications at
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> http://cve.mitre.org/cve/request_id.html]
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> {CMI: MCID15208901}
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>
> 
> 


