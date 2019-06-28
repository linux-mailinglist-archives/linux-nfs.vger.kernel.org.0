Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8595A557
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2019 21:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfF1Tsp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jun 2019 15:48:45 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:60709 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbfF1Tsp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 28 Jun 2019 15:48:45 -0400
Received: from [141.14.220.194] (unknown [141.14.220.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 387B9206695A7;
        Fri, 28 Jun 2019 21:48:43 +0200 (CEST)
Subject: Re: [PATCH 3/4 RESEND] nfs4: Move nfs4_setup_state_renewal
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>
References: <20190628123640.8715-1-buczek@molgen.mpg.de>
 <20190628123640.8715-4-buczek@molgen.mpg.de>
 <4a732990d3f2797591fb79ef0b04983a17a16c6e.camel@netapp.com>
From:   Donald Buczek <buczek@molgen.mpg.de>
Message-ID: <0f55b87b-fd5e-cc01-25f8-f0366de3fbe9@molgen.mpg.de>
Date:   Fri, 28 Jun 2019 21:48:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <4a732990d3f2797591fb79ef0b04983a17a16c6e.camel@netapp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dear Anna,

On 28.06.19 20:29, Schumaker, Anna wrote:
> Hi Donald,
> 
> On Fri, 2019-06-28 at 14:36 +0200, Donald Buczek wrote:
>> The function nfs4_setup_state_renewal is to be used by
>> nfs4_init_clientid. Move it further to the top of the source file to
>> include it regardles of CONFIG_NFS_V4_1 and to save a forward
>> declaration. No code changed.
>>
>> Signed-off-by: Donald Buczek <buczek@molgen.mpg.de>
>> ---
>>   fs/nfs/nfs4state.c | 42 +++++++++++++++++++++---------------------
>>   1 file changed, 21 insertions(+), 21 deletions(-)
>>
>> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
>> index 778ebfb00d13..c2df257f426f 100644
>> --- a/fs/nfs/nfs4state.c
>> +++ b/fs/nfs/nfs4state.c
>> @@ -87,6 +87,27 @@ const nfs4_stateid current_stateid = {
>>   
>>   static DEFINE_MUTEX(nfs_clid_init_mutex);
>>   
>> +static int nfs4_setup_state_renewal(struct nfs_client *clp)
>> +{
>> +	int status;
>> +	struct nfs_fsinfo fsinfo;
>> +	unsigned long now;
>> +
>> +	if (!test_bit(NFS_CS_CHECK_LEASE_TIME, &clp->cl_res_state)) {
>> +		nfs4_schedule_state_renewal(clp);
>> +		return 0;
>> +	}
>> +
>> +	now = jiffies;
>> +	status = nfs4_proc_get_lease_time(clp, &fsinfo);
> 
> nfs4_proc_get_lease_time() is defined under a CONFIG_NFS_V4_1 block, so
> this still won't compile. As far as I can tell, there isn't anything
> v4.1 specific to nfs4_proc_get_lease_time() and the corresponding xdr
> code so it's probably safe to move all this out too.

You're right. I'll fix that.

Thank you

   Donald

> 
> Anna
> 
>> +	if (status == 0) {
>> +		nfs4_set_lease_period(clp, fsinfo.lease_time * HZ,
>> now);
>> +		nfs4_schedule_state_renewal(clp);
>> +	}
>> +
>> +	return status;
>> +}
>> +
>>   int nfs4_init_clientid(struct nfs_client *clp, const struct cred
>> *cred)
>>   {
>>   	struct nfs4_setclientid_res clid = {
>> @@ -286,27 +307,6 @@ static int nfs4_begin_drain_session(struct
>> nfs_client *clp)
>>   
>>   #if defined(CONFIG_NFS_V4_1)
>>   
>> -static int nfs4_setup_state_renewal(struct nfs_client *clp)
>> -{
>> -	int status;
>> -	struct nfs_fsinfo fsinfo;
>> -	unsigned long now;
>> -
>> -	if (!test_bit(NFS_CS_CHECK_LEASE_TIME, &clp->cl_res_state)) {
>> -		nfs4_schedule_state_renewal(clp);
>> -		return 0;
>> -	}
>> -
>> -	now = jiffies;
>> -	status = nfs4_proc_get_lease_time(clp, &fsinfo);
>> -	if (status == 0) {
>> -		nfs4_set_lease_period(clp, fsinfo.lease_time * HZ,
>> now);
>> -		nfs4_schedule_state_renewal(clp);
>> -	}
>> -
>> -	return status;
>> -}
>> -
>>   static void nfs41_finish_session_reset(struct nfs_client *clp)
>>   {
>>   	clear_bit(NFS4CLNT_LEASE_CONFIRM, &clp->cl_state);

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
