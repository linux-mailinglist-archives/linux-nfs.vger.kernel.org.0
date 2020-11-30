Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EDA2C8D3C
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 19:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbgK3Str (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 13:49:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37026 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387844AbgK3Str (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 13:49:47 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUIn43Z187315;
        Mon, 30 Nov 2020 18:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=yTDpp2k5oK7tL/AYMHKPp2jccnH/FRzVdtZ/UZIL2jY=;
 b=rOjB43igedDaVT+GTe4ARAYrZsscutx4yNBd3zhz+7cRkoZKI+SpL0Ov0k+wO3P4BAFL
 sytmpkmCQCXiaSieXCCuJau4BGq+kDbvvN/G/I/JTeE5NS7Xd7ANRWPt5DbT41+IMhpw
 VSb2ku5XwDqI8DX4mtlE8kNMS9gGk29BV24BS2sZh2/YfJrKxFgb8nMXqWm6CEtIkshN
 4YRA5C/1WNHrG2UnlD9tqOPNlw2KhBdPlKi4SMr+E5BK+4BC2MJuKsreDsWtoHO+9T/G
 mdOJEfTAZ0bz5GkEE4O61KJCBp+Hmkn2tND4iXRk5+I5VJRuP4KtXtmcajyL3TvNsy1u Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 353egkepdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 18:49:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUIULwN167342;
        Mon, 30 Nov 2020 18:47:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 35404kx3ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 18:47:04 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AUIl3Yc005782;
        Mon, 30 Nov 2020 18:47:03 GMT
Received: from dhcp-10-154-154-74.vpn.oracle.com (/10.154.154.74)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Nov 2020 10:47:03 -0800
Subject: Re: [PATCH] NFSD: Fix 5 seconds delay when doing inter server copy
To:     Chuck Lever <chucklever@gmail.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20201124031609.67297-1-dai.ngo@oracle.com>
 <20201124204956.GB7173@fieldses.org>
 <9C1255B8-F52F-4797-9E2E-EF7EBE60C613@gmail.com>
From:   Dai Ngo <dai.ngo@oracle.com>
Message-ID: <ac9198ec-de07-6264-5bb1-684d31588339@oracle.com>
Date:   Mon, 30 Nov 2020 10:47:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <9C1255B8-F52F-4797-9E2E-EF7EBE60C613@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=11
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300121
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

Sorry for the delay. I will make update the patch, test it, and re-submit
it by end of today.

Thanks,
-Dai

On 11/30/20 9:57 AM, Chuck Lever wrote:
> Hello Dai -
>
>> On Nov 24, 2020, at 3:49 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>>
>> On Mon, Nov 23, 2020 at 10:16:09PM -0500, Dai Ngo wrote:
>>> Since commit b4868b44c5628 ("NFSv4: Wait for stateid updates after
>>> CLOSE/OPEN_DOWNGRADE"), every inter server copy operation suffers 5
>>> seconds delay regardless of the size of the copy. The delay is from
>>> nfs_set_open_stateid_locked when the check by nfs_stateid_is_sequential
>>> fails because the seqid in both nfs4_state and nfs4_stateid are 0.
>>>
>>> Fix by modifying the source server to return the stateid for COPY_NOTIFY
>>> request with seqid 1 instead of 0. This is also to conform with
>>> section 4.8 of RFC 7862.
>>>
>>> Here is the relevant paragraph from section 4.8 of RFC 7862:
>>>
>>>    A copy offload stateid's seqid MUST NOT be zero.  In the context of a
>>>    copy offload operation, it is inappropriate to indicate "the most
>>>    recent copy offload operation" using a stateid with a seqid of zero
>>>    (see Section 8.2.2 of [RFC5661]).  It is inappropriate because the
>>>    stateid refers to internal state in the server and there may be
>>>    several asynchronous COPY operations being performed in parallel on
>>>    the same file by the server.  Therefore, a copy offload stateid with
>>>    a seqid of zero MUST be considered invalid.
>>>
>>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>> fs/nfsd/nfs4state.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index d7f27ed6b794..33ee1a6961e3 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -793,6 +793,7 @@ struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
>>> 	refcount_set(&cps->cp_stateid.sc_count, 1);
>>> 	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, NFS4_COPYNOTIFY_STID))
>>> 		goto out_free;
>>> +	cps->cp_stateid.stid.si_generation = 1;
>> This affects the stateid returned by COPY_NOTIFY, but not the one
>> returned by COPY.  I think we wan to add this to nfs4_init_cp_state()
>> and cover both.
> Since time is creeping on towards the next merge window, I assume
> this particular fix needs to go there, but I don't see the final
> version of it (with Bruce's suggested fix) on the list. Did I miss
> it?
>
>
>>> 	spin_lock(&nn->s2s_cp_lock);
>>> 	list_add(&cps->cp_list, &p_stid->sc_cp_list);
>>> 	spin_unlock(&nn->s2s_cp_lock);
>>> -- 
>>> 2.9.5
> --
> Chuck Lever
> chucklever@gmail.com
>
>
>
