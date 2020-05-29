Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D461E87C5
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2020 21:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgE2T11 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 May 2020 15:27:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48208 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgE2T10 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 May 2020 15:27:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TJLreV169365;
        Fri, 29 May 2020 19:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=3qxOqaesPyrRrNuwrg9A6Iz+VpwiuvMQaao/kPwC+Uo=;
 b=0H1SzxC5NDZhMAVTl47sNWCD2vJyf0Q6s9HR0nfDAyr03qVW1ioP+lRu3J9dzk4gb7oY
 4y4S5dF0KJRIq9j4wwxiWwL/MlYu1cbPxnlOu5oGtFiDFqNPIkEkc4Kv6/J3txOhdcPg
 6IaR2ehsv/jaUPwOvYZPlM/C7s+Sqsy7SI1Mc+r0V56/TMXtDqadP85K0zPmJTHCH3L+
 1FQzDrFu42ndc+AQD4mQjOQQMWr+4AHRYYVtXxP2nkbiUTLFwjWwXHl4G44ezs8IHXbZ
 fVcSK1Duu7gtVTglsPrYP7MrZzIKoxcy8z7eplyljXFXqxri3Pb4lOAGINIt9OzA8m8q Ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 316u8rc3u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 19:27:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TJNjmg066965;
        Fri, 29 May 2020 19:27:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31a9kuntd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 19:27:12 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04TJR8RW022423;
        Fri, 29 May 2020 19:27:08 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 12:27:07 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: linux-next: manual merge of the nfsd tree with the nfs-anna tree
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200529105917.50dfc40f@canb.auug.org.au>
Date:   Fri, 29 May 2020 15:27:06 -0400
Cc:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <1AC5DB12-0E72-4AB6-B3B5-F1C40EC36F26@oracle.com>
References: <20200529105917.50dfc40f@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9636 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9636 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=0
 phishscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290146
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On May 28, 2020, at 8:59 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> Hi all,
> 
> Today's linux-next merge of the nfsd tree got a conflict in:
> 
>  include/trace/events/sunrpc.h
> 
> between commit:
> 
>  2baebf955125 ("SUNRPC: Split the xdr_buf event class")
> 
> from the nfs-anna tree and commit:
> 
>  998024dee197 ("SUNRPC: Add more svcsock tracepoints")
> 
> from the nfsd tree.

Alternately, I can provide a v4 nfsd-5.8 series for Bruce that
includes 2baebf955125 ("SUNRPC: Split the xdr_buf event class")
so that these merge conflicts are avoided.


> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc include/trace/events/sunrpc.h
> index 73193c79fcaa,852413cbb7d9..000000000000
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@@ -14,9 -14,41 +14,42 @@@
>  #include <linux/net.h>
>  #include <linux/tracepoint.h>
> 
> + TRACE_DEFINE_ENUM(SOCK_STREAM);
> + TRACE_DEFINE_ENUM(SOCK_DGRAM);
> + TRACE_DEFINE_ENUM(SOCK_RAW);
> + TRACE_DEFINE_ENUM(SOCK_RDM);
> + TRACE_DEFINE_ENUM(SOCK_SEQPACKET);
> + TRACE_DEFINE_ENUM(SOCK_DCCP);
> + TRACE_DEFINE_ENUM(SOCK_PACKET);
> + 
> + #define show_socket_type(type)					\
> + 	__print_symbolic(type,					\
> + 		{ SOCK_STREAM,		"STREAM" },		\
> + 		{ SOCK_DGRAM,		"DGRAM" },		\
> + 		{ SOCK_RAW,		"RAW" },		\
> + 		{ SOCK_RDM,		"RDM" },		\
> + 		{ SOCK_SEQPACKET,	"SEQPACKET" },		\
> + 		{ SOCK_DCCP,		"DCCP" },		\
> + 		{ SOCK_PACKET,		"PACKET" })
> + 
> + /* This list is known to be incomplete, add new enums as needed. */
> + TRACE_DEFINE_ENUM(AF_UNSPEC);
> + TRACE_DEFINE_ENUM(AF_UNIX);
> + TRACE_DEFINE_ENUM(AF_LOCAL);
> + TRACE_DEFINE_ENUM(AF_INET);
> + TRACE_DEFINE_ENUM(AF_INET6);
> + 
> + #define rpc_show_address_family(family)				\
> + 	__print_symbolic(family,				\
> + 		{ AF_UNSPEC,		"AF_UNSPEC" },		\
> + 		{ AF_UNIX,		"AF_UNIX" },		\
> + 		{ AF_LOCAL,		"AF_LOCAL" },		\
> + 		{ AF_INET,		"AF_INET" },		\
> + 		{ AF_INET6,		"AF_INET6" })
> + 
> -DECLARE_EVENT_CLASS(xdr_buf_class,
> +DECLARE_EVENT_CLASS(rpc_xdr_buf_class,
>  	TP_PROTO(
> +		const struct rpc_task *task,
>  		const struct xdr_buf *xdr
>  	),
> 

--
Chuck Lever



