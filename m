Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C192C8E33
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 20:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgK3Tis (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 14:38:48 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58940 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgK3Tir (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 14:38:47 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUJSthk012528;
        Mon, 30 Nov 2020 19:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=KBI6g/HqSroncZwzOwpWBU8IzFF4FQwe1M2QxgGrzqo=;
 b=BywGEsWzst4h2FQ8LWUkQKfjlVr7tJjBvkx9vPMWXFcdntdfKbxbG4R3EzB6W2jVr1nh
 IhnlLtJTZKuvjSUmvv1kadRP28mrO+iypAA3fzzSeEvKAYKOJog1BUZChvOLbfuq8O20
 v11r44YA5x+m7ktxlUbu0aUPpbJEGlgc8z2zFd6IGp0a2w16w/1Y1YOyrrBOsgbZ61PE
 Q9tueLp1iGgP9wgyV82gNsb3xpZJ0i9Qp+CkH5hqVOeNI9kKLlCZVisfw2bEc5VBnC0l
 Xo7YWef1t8D3PkPEi4wFtOeSkbIr3Mhd+U5gTRFwRJpf49kzch2QuqwfwVNgARg5Z8Gt NA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 353c2aq3n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 19:37:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUJUN8Z147929;
        Mon, 30 Nov 2020 19:37:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 35404kytcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 19:37:57 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AUJbsUS010380;
        Mon, 30 Nov 2020 19:37:54 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Nov 2020 11:37:54 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v1] SUNRPC: Remove XDRBUF_SPARSE_PAGES flag in gss_proxy
 upcall
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyFP6F1Q+gGBLwfwazuaw7WYu-UGfd=Bb0nOmxgU0e_uxw@mail.gmail.com>
Date:   Mon, 30 Nov 2020 14:37:53 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Simo Sorce <simo@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3ED91324-7BC3-4A55-87B4-4A21177D6C48@oracle.com>
References: <160625754220.280431.690992380938118353.stgit@klimt.1015granger.net>
 <CAN-5tyFP6F1Q+gGBLwfwazuaw7WYu-UGfd=Bb0nOmxgU0e_uxw@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300126
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 30, 2020, at 2:33 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Tue, Nov 24, 2020 at 7:04 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>> Commit 9dfd87da1aeb ("rpc: fix huge kmalloc's in gss-proxy") added
>> gssp_alloc_receive_pages() to fully allocate the receive buffer
>> for gss_proxy upcalls.
>>=20
>> However, later, 431f6eb3570f ("SUNRPC: Add a label for RPC calls
>> that require allocation on receive") sets the XDRBUF_SPARSE_PAGES
>> flag for this receive buffer anyway. That doesn't appear to have
>> been necessary, since gssp_alloc_receive_pages() still exists.
>=20
> But the gssp_alloc_receive_pages() only allocates the array of page
> pointers not the actual pages, so I believe the flag is still needed
> to have those pages allocated by something? What is allocating those
> pages if not the SPARSE_PAGES method, what am I missing?

Ugh <face palm>

gssp_alloc_receive_pages() will have to allocate those pages.

Again, I don't see any reason to defer page allocation from a context
in which GFP_KERNEL is allowed to one where it isn't, and where we
know exactly how many pages are needed.

I'll respin. Good catch!


>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> net/sunrpc/auth_gss/gss_rpc_xdr.c |    1 -
>> 1 file changed, 1 deletion(-)
>>=20
>> diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c =
b/net/sunrpc/auth_gss/gss_rpc_xdr.c
>> index 2ff7b7083eba..44838f6ea25e 100644
>> --- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
>> +++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
>> @@ -771,7 +771,6 @@ void gssx_enc_accept_sec_context(struct rpc_rqst =
*req,
>>        xdr_inline_pages(&req->rq_rcv_buf,
>>                PAGE_SIZE/2 /* pretty arbitrary */,
>>                arg->pages, 0 /* page base */, arg->npages * =
PAGE_SIZE);
>> -       req->rq_rcv_buf.flags |=3D XDRBUF_SPARSE_PAGES;
>> done:
>>        if (err)
>>                dprintk("RPC:       gssx_enc_accept_sec_context: =
%d\n", err);
>>=20
>>=20

--
Chuck Lever



