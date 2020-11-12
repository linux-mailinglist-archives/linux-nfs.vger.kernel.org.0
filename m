Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D939E2B0E70
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 20:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgKLTq3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 14:46:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46408 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKLTq3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 14:46:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ACJTscG036264
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 19:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=hABg66VUNTkExNPkmbdj88rBScjqQ5FCqF7zGf4Gd+g=;
 b=D3Nd9MpaTwRqIty8Cp6ogUZVoDRToi4JK/oszbrDXbqji6Riv4UyLt4yy/Oa7LNIlihR
 ycvfOmeo0WxbIkpplNI+/FOFma4nio6kRGrFNBsNZnUOowRD8e7VdCUbjUmxUOxuIzfE
 R84uttagw22DSbF03USYqZeYBag5On1HrdwUKQ6Ff5qx+4HN/CFomvbFH9hfxPGed2ph
 5O1v9obBsFTgEh4JhI0PfJ2P28Nr25Wclrj6GZkEBa+isyK7vPTpYdUrz2M1kIHloPK/
 Nm07ZDFvEUv1ibcEEg+h8rcxn3tsj3018nd6NrlW29abMZk9kCWsOlHAXcII+Vo+jjIc Tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34nkhm797x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 19:46:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ACJVJn9117416
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 19:46:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34p55rsya8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 19:46:27 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ACJkQ5p017135
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 19:46:26 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Nov 2020 11:46:26 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v1 2/4] NFSD: Clean up the show_nf_may macro
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <60bf9c24-a944-17c0-6f54-6dbb53970f44@oracle.com>
Date:   Thu, 12 Nov 2020 14:46:25 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <817709CD-6F13-4F34-92B1-BB3D2362EFA3@oracle.com>
References: <160519319763.1658.12613346131541001302.stgit@klimt.1015granger.net>
 <160519326660.1658.18351054451047271453.stgit@klimt.1015granger.net>
 <60bf9c24-a944-17c0-6f54-6dbb53970f44@oracle.com>
To:     Calum Mackay <calum.mackay@oracle.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120116
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 12, 2020, at 2:45 PM, Calum Mackay <calum.mackay@oracle.com> =
wrote:
>=20
> On 12/11/2020 3:01 pm, Chuck Lever wrote:
>> Display all currently possible NFSD_MAY permission flags.
>> Move and rename show_nf_may with a more generic name because the
>> NFSD_MAY permission flags are used in other places besides the file
>> cache.
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/trace.h |   40 ++++++++++++++++++++++++++--------------
>>  1 file changed, 26 insertions(+), 14 deletions(-)
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index 99bf07800cd0..532b66a4b7f1 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -12,6 +12,22 @@
>>  #include "export.h"
>>  #include "nfsfh.h"
>>  +#define show_nfsd_may_flags(x)						=
\
>> +	__print_flags(x, "|",						=
\
>> +		{ NFSD_MAY_EXEC,		"EXEC" },		=
\
>> +		{ NFSD_MAY_WRITE,		"WRITE" },		=
\
>> +		{ NFSD_MAY_READ,		"READ" },		=
\
>> +		{ NFSD_MAY_SATTR,		"SATTR" },		=
\
>> +		{ NFSD_MAY_TRUNC,		"TRUNC" },		=
\
>> +		{ NFSD_MAY_LOCK,		"LOCK" },		=
\
>> +		{ NFSD_MAY_OWNER_OVERRIDE,	"OWNER_OVERRIDE" },	=
\
>> +		{ NFSD_MAY_LOCAL_ACCESS,	"LOCAL_ACCESS" },	=
\
>> +		{ NFSD_MAY_BYPASS_GSS_ON_ROOT,	"BYPASS_GSS_ON_ROOT" },	=
\
>> +		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAD_LEASE" },	=
\
>=20
> typo :)

Amusing! Fixed.


>> +		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		=
\
>> +		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	=
\
>> +		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
>> +
>>  TRACE_EVENT(nfsd_compound,
>>  	TP_PROTO(const struct svc_rqst *rqst,
>>  		 u32 args_opcnt),
>> @@ -421,6 +437,9 @@ TRACE_EVENT(nfsd_clid_inuse_err,
>>  		__entry->cl_boot, __entry->cl_id)
>>  )
>>  +/*
>> + * from fs/nfsd/filecache.h
>> + */
>>  TRACE_DEFINE_ENUM(NFSD_FILE_HASHED);
>>  TRACE_DEFINE_ENUM(NFSD_FILE_PENDING);
>>  TRACE_DEFINE_ENUM(NFSD_FILE_BREAK_READ);
>> @@ -435,13 +454,6 @@ TRACE_DEFINE_ENUM(NFSD_FILE_REFERENCED);
>>  		{ 1 << NFSD_FILE_BREAK_WRITE,	"BREAK_WRITE" },	=
\
>>  		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"})
>>  -/* FIXME: This should probably be fleshed out in the future. */
>> -#define show_nf_may(val)						=
\
>> -	__print_flags(val, "|",						=
\
>> -		{ NFSD_MAY_READ,		"READ" },		=
\
>> -		{ NFSD_MAY_WRITE,		"WRITE" },		=
\
>> -		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" })
>> -
>>  DECLARE_EVENT_CLASS(nfsd_file_class,
>>  	TP_PROTO(struct nfsd_file *nf),
>>  	TP_ARGS(nf),
>> @@ -466,7 +478,7 @@ DECLARE_EVENT_CLASS(nfsd_file_class,
>>  		__entry->nf_inode,
>>  		__entry->nf_ref,
>>  		show_nf_flags(__entry->nf_flags),
>> -		show_nf_may(__entry->nf_may),
>> +		show_nfsd_may_flags(__entry->nf_may),
>>  		__entry->nf_file)
>>  )
>>  @@ -492,10 +504,10 @@ TRACE_EVENT(nfsd_file_acquire,
>>  		__field(u32, xid)
>>  		__field(unsigned int, hash)
>>  		__field(void *, inode)
>> -		__field(unsigned int, may_flags)
>> +		__field(unsigned long, may_flags)
>>  		__field(int, nf_ref)
>>  		__field(unsigned long, nf_flags)
>> -		__field(unsigned char, nf_may)
>> +		__field(unsigned long, nf_may)
>>  		__field(struct file *, nf_file)
>>  		__field(u32, status)
>>  	),
>> @@ -514,10 +526,10 @@ TRACE_EVENT(nfsd_file_acquire,
>>    	TP_printk("xid=3D0x%x hash=3D0x%x inode=3D0x%p may_flags=3D%s =
ref=3D%d nf_flags=3D%s nf_may=3D%s nf_file=3D0x%p status=3D%u",
>>  			__entry->xid, __entry->hash, __entry->inode,
>> -			show_nf_may(__entry->may_flags), =
__entry->nf_ref,
>> -			show_nf_flags(__entry->nf_flags),
>> -			show_nf_may(__entry->nf_may), __entry->nf_file,
>> -			__entry->status)
>> +			show_nfsd_may_flags(__entry->may_flags),
>> +			__entry->nf_ref, =
show_nf_flags(__entry->nf_flags),
>> +			show_nfsd_may_flags(__entry->nf_may),
>> +			__entry->nf_file, __entry->status)
>>  );
>>    DECLARE_EVENT_CLASS(nfsd_file_search_class,
>=20
> --=20
> Calum Mackay
> Linux Kernel Engineering
> Oracle Linux and Virtualisation

--
Chuck Lever



