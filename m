Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2C022D02E
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jul 2020 23:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgGXVFM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Jul 2020 17:05:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51046 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGXVFL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Jul 2020 17:05:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OKw1Aj121261;
        Fri, 24 Jul 2020 21:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=bV9MRAGppDE0RhpEHREzgFCxKxpAuzP/7UBBmoQYIv0=;
 b=E6St2wFzJ7MAkBu1bNqcJMUMfXjNy6ChaDUsfgnn2251sUA8WxHsrlsf/RxuF1aKlevQ
 IVS84jJH1DTL/0NbCG7Nmxtyl10/9dcOaLLlINZaOCY36Darww6HZOlEe/ez953xa5eo
 PgofevwZhbYYZSemofqakJvAlokchjaOKZzJlvs0sitS71bj+FZhWEYXCdA1mN/+OMRS
 knlK6a4ltpLhAEYiQ4JRhNX1oh941u3xjjkGUYVdkxWfF4ttDE6osX4HT6wKU3fAA+lv
 5cYw6IeFKLPhMylfTPCYPUq/XxNC+trxLgfSecj+1aXGu97XrVYlhSdBCcmRVNjJCIGe XQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32d6kt5et7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jul 2020 21:05:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OKwi0O111041;
        Fri, 24 Jul 2020 21:05:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32g738gd08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 21:05:08 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06OL57Ha003762;
        Fri, 24 Jul 2020 21:05:07 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jul 2020 21:05:06 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: fix_priv_head
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200724203900.GB9244@fieldses.org>
Date:   Fri, 24 Jul 2020 17:05:05 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <8005DB66-EC25-4DE2-847B-CEAD9BBE48E3@oracle.com>
References: <3799C9E0-DFF3-450C-A815-14BAFAC97EA8@oracle.com>
 <20200723193811.GG31487@fieldses.org>
 <94381D74-3563-4071-A0CF-4EC016744FEC@oracle.com>
 <20200724011720.GH31487@fieldses.org>
 <7557A354-8396-448D-BFC5-CA5512A4516B@oracle.com>
 <20200724203900.GB9244@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240143
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 24, 2020, at 4:39 PM, Bruce Fields <bfields@fieldses.org> wrote:
> 
> On Fri, Jul 24, 2020 at 10:10:08AM -0400, Chuck Lever wrote:
>>>> I'd like to remove this code, but
>>>> I'd first like to understand how it will effect the code that follows
>>>> immediately after:
>>>> 
>>>>       offset = xdr_pad_size(buf->head[0].iov_len);
>>>>       if (offset) {
>>>>               buf->buflen = RPCSVC_MAXPAYLOAD;
>>>>               xdr_shift_buf(buf, offset);
>>>>               fix_priv_head(buf, pad);
>>>>       }
>> 
>> So if one of those patches removes "pad = priv_len - buf->len;"
>> then the above code will break.
>> 
>> But I'm trying to see when it is possible for gss_unwrap to
>> return a head buffer that is not quad-aligned. Not coming up
>> with any such scenario.
> 
> Thinking about it more, even if there was some gss mechanism returning
> misaligned data, the best place to fix that would likely be in the
> mechanism-specific code (partly for reasons noted in the comment right
> here--it'll be more efficient to put the data in the right spot as you
> encrypt it.)

In principal, I totally agree that the GSS mechanism's unwrap method is
the obvious place to handle mis-alignment. The practical challenge in
this code path is that the needs of the client and server receive logic
diverge just enough to make it annoying.


So another remark about this:

static void
fix_priv_head(struct xdr_buf *buf, int pad)
{
        if (buf->page_len == 0) {
                /* We need to adjust head and buf->len in tandem in this
                 * case to make svc_defer() work--it finds the original
                 * buffer start using buf->len - buf->head[0].iov_len. */
                buf->head[0].iov_len -= pad;
        }
}

The comment complains about svc_defer, and that particular calculation
is still in that code. It seems like it would be better if a pointer
into buf->head was saved somewhere instead of trying to manufacture
it based on buf->len, which seems to be pretty unreliable.

If svc_defer was changed that way, that might help us get rid of at
least the first fix_priv_head call site.

--
Chuck Lever



