Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EACBB9826A
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2019 20:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfHUSLb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Aug 2019 14:11:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35042 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfHUSLb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Aug 2019 14:11:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LI4Rgu120269;
        Wed, 21 Aug 2019 18:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=LNf/BiY2c1aCxKX7cjTK7slHPQCUjmmpu+MZQ6fjJdM=;
 b=Q+hfVBsuRY7LWwkM8gzMb09S5nUtD+VJG9UkvLHZMRuVRVaQ7j1e7AkOTs+4eNTzY5CL
 kbUfqc3f0XgqPzDfYvdGObfzkfmSdAtgJupFG7WtazzTDPzdtAoPwJgAiPdm3DB7Zx70
 3lum28/+AfuTlUV3MX8eElOcvCXgTJLI3PyQJwnhOCM1lwxK2Rgt0+++QaOz3LMVU0BQ
 582k2TLAcRLU+e+JeBJbUFDNjJII25iIj9uBiPfSbgBeiCXgQmztV/gwC2tyDi2joDad
 /1P93IsvXfn0svPk/JYacz1GbdwMECFkk3UwN9XprhmMAaTtWsQpgKrzM8LbSq1BrJ8c Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ue9hpqd81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 18:11:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LI32BP145251;
        Wed, 21 Aug 2019 18:11:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2ugj7q6k10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 18:11:24 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7LIBNCq019908;
        Wed, 21 Aug 2019 18:11:23 GMT
Received: from [10.132.92.146] (/10.132.92.146)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 11:11:23 -0700
Subject: Re: kernel panic in 5.3-rc5, nfsd_reply_cache_stats_show+0x11
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     CHUCK_LEVER <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <72e41dc2-b4cf-a5dd-a365-d26ba1257ef9@oracle.com>
 <CAPcyv4iPuTpk9bifyX5yQxO8gT0fRhYXPrwk-obazWA=Dou3iQ@mail.gmail.com>
From:   jane.chu@oracle.com
Organization: Oracle Corporation
Message-ID: <74aeafff-a123-bf20-4b5e-9cd636bdb22e@oracle.com>
Date:   Wed, 21 Aug 2019 11:11:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iPuTpk9bifyX5yQxO8gT0fRhYXPrwk-obazWA=Dou3iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210180
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210180
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi, Dan,

On 8/20/19 8:48 PM, Dan Williams wrote:
> On Tue, Aug 20, 2019 at 6:39 PM <jane.chu@oracle.com> wrote:
>>
>> Hi,
>>
>> Apology if there is a better channel reporting the issue, if so, please
>> let me know.
>>
>> I just saw below regression in 5.3-rc5 kernel, but not in 5.2-rc7 or
>> earlier kernels.
> 
> Is the error stable enough to bisect?
> 

The error is stable, I haven't tried bisect, thought to report the issue
first since it's late in the 5.3 process.
Then saw Bruce' email, I'll report soon whether the patch takes care the 
issue.

thanks!
-jane
