Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EE41B64AD
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2020 21:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgDWToF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Apr 2020 15:44:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51420 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgDWToF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Apr 2020 15:44:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NJgism129191;
        Thu, 23 Apr 2020 19:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=YMQc1kuGl6pqOgoz+h8brmaVlw6G+a9FkrDyb4yyq/s=;
 b=eSVj19TAzxio57QA+mosaCyPoB8ZIi494ioZbkY2wpGHqyseqfy+Y40lybqfpNCru6WX
 zHVOHBj8o2lQ+uBshAHWF+tGVCIa4ksD/i9DP+9+1V7GzyRuKC/yVuPrX7bW7kcqB7Q2
 BwooAYSrpB5/OYDdWHarvJBEveqzhvnixvdwl9L7h55khnNJDIR+bTgnVTwSSH337Lkh
 SzaAvLr+E6OmoDcVLmKkw9manAbNoaRJIVe1Vdjak1Xh85Mv19Ii4WNSL4t1FHBRpSXr
 jI7yLiNaSh7Nvvt9L+OmwJq4Mesu1GMfYf1Cd0Ss8flyB4XWu8fN9cZyT/xFj50AE9zn SQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30jvq4wjwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 19:44:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NJfhMq167518;
        Thu, 23 Apr 2020 19:42:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30gb3w560k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 19:42:00 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03NJfuYT017250;
        Thu, 23 Apr 2020 19:41:59 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Apr 2020 12:41:56 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: GSS unwrapping breaks the DRC
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200423193405.GB4561@fieldses.org>
Date:   Thu, 23 Apr 2020 15:41:53 -0400
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <9B405815-0F35-4330-842F-1980E76A9309@oracle.com>
References: <DAED9EC8-7461-48FF-AD6C-C85FB968F8A6@oracle.com>
 <20200415192542.GA6466@fieldses.org>
 <0775FBE7-C2DD-4ED6-955D-22B944F302E0@oracle.com>
 <20200415215823.GB6466@fieldses.org>
 <39815C35-EAD8-4B2E-B48F-88F3D5B10C57@oracle.com>
 <AA069628-0668-4F15-8C29-23997D04185B@oracle.com>
 <20200423193405.GB4561@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=543 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=589 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230147
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

> On Apr 23, 2020, at 3:34 PM, Bruce Fields <bfields@fieldses.org> wrote:
> 
> On Fri, Apr 17, 2020 at 05:48:35PM -0400, Chuck Lever wrote:
>> I've hit a snag here.
>> 
>> I reverted 241b1f419f0e on my server, and all tests completed
>> successfully.
>> 
>> I reverted 241b1f419f0e on my client, and now krb5p is failing. Using
>> xdr_buf_trim does the right thing on the server, but on the client it
>> has exposed a latent bug in gss_unwrap_resp_priv() (ie, the bug does
>> not appear to be harmful until 241b1f419f0e has been reverted).
>> 
>> The calculation of au_ralign in that function is wrong, and that forces
>> rpc_prepare_reply_pages to allocate a zero-length tail. xdr_buf_trim()
>> then lops off the end of each subsequent clear-text RPC message, and
>> eventually a short READ results in test failures.
>> 
>> After experimenting with this for a day, I don't see any way for
>> gss_unwrap_resp_priv() to estimate au_ralign based on what gss_unwrap()
>> has done to the xdr_buf. The kerberos_v1 unwrap method does not appear
>> to have any trailing checksum, for example, but v2 does.
>> 
>> The best approach for now seems to be to have the pseudoflavor-specific
>> unwrap methods return the correct ralign value. A straightforward way
>> to do this would be to add a *int parameter to ->gss_unwrap that would
>> be set to the proper value; or hide that value somewhere in the xdr_buf.
>> 
>> Any other thoughts or random bits of inspiration?
> 
> No.  Among other things, a quick skim wasn't enough to remind me what
> au_ralign is and why we have both that and au_rslack....  Sorry!  I've
> got not much to offer but sympathy.

I added au_ralign last year to deal with where the beginning of the
encapsulated upper layer message lands. So:

au_verfsize - the size of the RPC header's verifier field
au_ralign - the offset of the start of the upper layer results
au_rslack - the total size of the RPC header and results

Note that the krb5_v2 unwrapper deals with this already. It's got
headskip and tailskip. The v1 unwrapper doesn't need to worry about
trailing GSS data.

The purpose of this is to ensure that the upper layer's data payload
(ie, what is supposed to land in the buf->pages most of the time)
is not going to need to be re-aligned via a memcpy. au_ralign is
used to this effect in rpc_prepare_reply_pages when setting up
rq_rcv_buf.


> ...
> 
> I have a random thought out of left field: after the xdr_stream
> conversion, fs/nfs/nfs4xdr.c mostly doesn't deal directly with the reply
> buffer any more.  It calls xdr_inline_decode(xdr, n) and gets back a
> pointer to the next n bytes of rpc data.  Or it calls xdr_read_pages()
> after which read data's supposed to be moved to the right place.
> 
> Would it be possible to delay rpcsec_gss decoding until then?  Would
> that make things simpler or more complicated?
> 
> Eh, I think the answer is probably "more complicated".
> 
> --b.

--
Chuck Lever



