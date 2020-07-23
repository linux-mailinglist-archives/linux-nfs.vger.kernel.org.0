Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CA122B798
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jul 2020 22:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgGWUXL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jul 2020 16:23:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35022 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgGWUXL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Jul 2020 16:23:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06NK6e8i054028;
        Thu, 23 Jul 2020 20:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=GFf8Qly+0l8ln5Dya+3iIsMfvYIHhAH16gqp5qlinNc=;
 b=mgDUaeGSpmiHVY+XKHWqfmuKDqR2Zpo+QlHhIwHdMps5j6qlxUewl2AsX1J3T0qlCiZA
 mZwe5TAONVmglKPRZjjnbtyHcxOhoVk+TyCW9BB7AQj9FJs7meIYO16pGUT0ZIkrnncu
 flfPwes5TMZr09IE44/w6nGmBf/eDMT+MVCCKMfFQ5lkxc7rCCthgH6MXUzeQ25qaLHz
 UsxFtYQQu3R9hPOchjhACF4335c8dfWkBWtF74ib8ycwTWHV/iE8SzDVoWb/D9WBvVmB
 0ph4+Z0YtzkDuJO1/Lo53Rd8lZt+bfe1TM4MHTFRtvcUS5ftDa+43DPx9GYtOBRTLYF5 og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32brgruqfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jul 2020 20:23:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06NK8KJn058493;
        Thu, 23 Jul 2020 20:23:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32feb1s4gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 20:23:08 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06NKN6jg024683;
        Thu, 23 Jul 2020 20:23:07 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jul 2020 13:23:05 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: fix_priv_head
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200723193811.GG31487@fieldses.org>
Date:   Thu, 23 Jul 2020 16:23:05 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <94381D74-3563-4071-A0CF-4EC016744FEC@oracle.com>
References: <3799C9E0-DFF3-450C-A815-14BAFAC97EA8@oracle.com>
 <20200723193811.GG31487@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007230145
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 23, 2020, at 3:38 PM, Bruce Fields <bfields@fieldses.org> wrote:
> 
> On Thu, Jul 23, 2020 at 01:46:19PM -0400, Chuck Lever wrote:
>> Hi Bruce-
>> 
>> I'm trying to figure out if fix_priv_head is still necessary. This
>> was introduced by 7c9fdcfb1b64 ("[PATCH] knfsd: svcrpc: gss:
>> server-side implementation of rpcsec_gss privacy").
>> 
>> static void
>> fix_priv_head(struct xdr_buf *buf, int pad)
>> {
>>        if (buf->page_len == 0) {
>>                /* We need to adjust head and buf->len in tandem in this
>>                 * case to make svc_defer() work--it finds the original
>>                 * buffer start using buf->len - buf->head[0].iov_len. */
>>                buf->head[0].iov_len -= pad;
>>        }
>> }
>> 
>> It doesn't seem like unwrapping can ever result in a buffer length that
>> is not quad-aligned. Is that simply a characteristic of modern enctypes?

And: how is it correct to subtract "pad" ? if the length of the content
is not aligned, this truncates it. Instead, shouldn't the length be
extended to the next quad-boundary?


> This code is before any unwrapping.  We're looking at the length of the
> encrypted (wrapped) object here, not the unwrapped buffer.

fix_priv_head() is called twice: once before and once after gss_unwrap.

There is also this adjustment, just after the gss_unwrap() call:

        maj_stat = gss_unwrap(ctx, 0, priv_len, buf);
        pad = priv_len - buf->len;
        buf->len -= pad;

This is actually a bug, now that gss_unwrap adjusts buf->len: subtracting
"pad" can make buf->len go negative. I'd like to remove this code, but
I'd first like to understand how it will effect the code that follows
immediately after:

        offset = xdr_pad_size(buf->head[0].iov_len);
        if (offset) {
                buf->buflen = RPCSVC_MAXPAYLOAD;
                xdr_shift_buf(buf, offset);
                fix_priv_head(buf, pad);
        }

> When using privacy, the body of an rpcsec_gss request is a single opaque
> object consisting of the wrapped data.  So the question is whether
> there's any case where the length of that object can be less than the
> length remaining in the received buffer.
> 
> I think the only reason for bytes at the end is, yes, that that opaque
> object is not a multiple of 4 and so rpc requires padding at the end.

Newer enctypes seem to put something substantial beyond the end of
the opaque. That's why gss_unwrap_kerberos_v2() finishes with a
call to xdr_buf_trim().

But I'm not sure why the receiver should care about a misaligned size
of the opaque.

The GSS mechanism's unwrap method should set buf->len to the size
of the unencrypted payload message, and for RPC, that size should
always be a multiple of four, and will exclude any of those extra
bytes.


--
Chuck Lever



