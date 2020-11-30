Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559552C900F
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 22:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbgK3V3G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 16:29:06 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52994 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbgK3V3G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 16:29:06 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AULOq8s093472;
        Mon, 30 Nov 2020 21:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=c7DlL33is7asJZ8TFrSKmI3u8uWV0dUSFa2bSSm7J4c=;
 b=lhfYN7b9BoeaNMfVNccqGCpuWIL3Qg/BO1S2RxmXzmdoVgczl6zWI+NStEGw6/I/kDAi
 X3nI8k5FlearueYLKXoeWTt+K+U/1A6qFcO5WZgHy7DUUkpKXuDQwLHTC5diApJvB/vd
 YZs+0ORxnGF756o63D92xNxr0k3EqX/Z3D2KJ14k08VO9IEVH7AYlkj9xo4W6erTjae4
 m6i9SnJPdIA8T4c64SGqZuPfPeLRRKcVfw+pYyDamRS1PObvaQL/pGt1+374wuDhN9De
 M+T03cAJGggxAL+TGmCQC+2S2xW2PlSjneJoVRZfJEaS/L+GQ83ILBwn8XHRPsB56utG Nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 353egkfe38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 21:28:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AULQDuP087726;
        Mon, 30 Nov 2020 21:28:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3540ar6awd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 21:28:23 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AULSMFM002167;
        Mon, 30 Nov 2020 21:28:22 GMT
Received: from dhcp-10-154-154-74.vpn.oracle.com (/10.154.154.74)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Nov 2020 13:28:21 -0800
Subject: Re: [PATCH] NFSD: Fix 5 seconds delay when doing inter server copy
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
References: <20201124031609.67297-1-dai.ngo@oracle.com>
 <20201124204956.GB7173@fieldses.org>
From:   Dai Ngo <dai.ngo@oracle.com>
Message-ID: <8d06ce44-78c4-a0fc-bf99-c104b2622889@oracle.com>
Date:   Mon, 30 Nov 2020 13:28:20 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201124204956.GB7173@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=11
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=11
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300135
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 11/24/20 12:49 PM, J. Bruce Fields wrote:
> On Mon, Nov 23, 2020 at 10:16:09PM -0500, Dai Ngo wrote:
>> Since commit b4868b44c5628 ("NFSv4: Wait for stateid updates after
>> CLOSE/OPEN_DOWNGRADE"), every inter server copy operation suffers 5
>> seconds delay regardless of the size of the copy. The delay is from
>> nfs_set_open_stateid_locked when the check by nfs_stateid_is_sequential
>> fails because the seqid in both nfs4_state and nfs4_stateid are 0.
>>
>> Fix by modifying the source server to return the stateid for COPY_NOTIFY
>> request with seqid 1 instead of 0. This is also to conform with
>> section 4.8 of RFC 7862.
>>
>> Here is the relevant paragraph from section 4.8 of RFC 7862:
>>
>>     A copy offload stateid's seqid MUST NOT be zero.  In the context of a
>>     copy offload operation, it is inappropriate to indicate "the most
>>     recent copy offload operation" using a stateid with a seqid of zero
>>     (see Section 8.2.2 of [RFC5661]).  It is inappropriate because the
>>     stateid refers to internal state in the server and there may be
>>     several asynchronous COPY operations being performed in parallel on
>>     the same file by the server.  Therefore, a copy offload stateid with
>>     a seqid of zero MUST be considered invalid.
>>
>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index d7f27ed6b794..33ee1a6961e3 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -793,6 +793,7 @@ struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
>>   	refcount_set(&cps->cp_stateid.sc_count, 1);
>>   	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, NFS4_COPYNOTIFY_STID))
>>   		goto out_free;
>> +	cps->cp_stateid.stid.si_generation = 1;
> This affects the stateid returned by COPY_NOTIFY, but not the one
> returned by COPY.  I think we wan to add this to nfs4_init_cp_state()
> and cover both.

Hi Bruce, thank you for your suggestion. Updated patch tested and submitted.

-Dai

P.S sorry for the delay, I was on leave last few days.

>
> --b.
>
>>   	spin_lock(&nn->s2s_cp_lock);
>>   	list_add(&cps->cp_list, &p_stid->sc_cp_list);
>>   	spin_unlock(&nn->s2s_cp_lock);
>> -- 
>> 2.9.5
