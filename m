Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4D32C146C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 20:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgKWTVH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 14:21:07 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33330 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbgKWTVH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 14:21:07 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANJ8mew034712;
        Mon, 23 Nov 2020 19:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=BVkAbxGBJdZwMgbg2CWg6P4E2P89xptBjRd+PqCYnWY=;
 b=kCKtKbcZMOiUq6b+L3cwNFeVhI+6fL4Rd6npwip/aXfSRcec/ki9oQNXWcoFQXhEPkIB
 FVCvvXWOtrpJLB37MppFMHr+/yfUE9BXH9CDfKZV8q4T6IYl5sr9mV6cOhD9x9Zejnyr
 lmI/g8Anro+0EkcIs6KFQrDSUFvMGKRPdI80JuF9sBy+sbFfS8l+KnZmAdFDWOM0n4Zt
 oXlvEBLQ0jQssY4GbXAWR/kPUTtg0wvCJhIauNcmYxUwIKdP/afMX8cSv+vQpycY00kD
 HzLe0ig2KgKW/WRXHmVltDTKUoCksC602lnph360KZUsbDFuz08boSyylG4sTYFrPb7b 5w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34xrdaq3tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Nov 2020 19:21:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANJ9o5d140597;
        Mon, 23 Nov 2020 19:21:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34ycnrc4yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 19:21:04 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ANJL3ua014045;
        Mon, 23 Nov 2020 19:21:03 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Nov 2020 11:21:03 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2 005/118] NFSD: Replace the internals of the READ_BUF()
 macro
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201123191840.GH32599@fieldses.org>
Date:   Mon, 23 Nov 2020 14:21:02 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B66AC8A-F7E8-421C-ACDC-C6887CEEBB34@oracle.com>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
 <160590445271.1340.9408337302317384948.stgit@klimt.1015granger.net>
 <20201123191840.GH32599@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230125
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 23, 2020, at 2:18 PM, bfields@fieldses.org wrote:
>=20
> On Fri, Nov 20, 2020 at 03:34:12PM -0500, Chuck Lever wrote:
>> @@ -396,7 +281,7 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs =
*argp, u32 *bmval,
>> 		READ_BUF(4); len +=3D 4;
>> 		nace =3D be32_to_cpup(p++);
>>=20
>> -		if (nace > compoundargs_bytes_left(argp)/20)
>> +		if (nace > xdr_stream_remaining(argp->xdr) / =
sizeof(struct nfs4_ace))
>=20
> Picky C question: is the compiler guaranteed to pack that struct in =
the
> obvious way?
>=20
> That aside, I'm not comfortable assuming the struct could never change
> to, say, include something that's useful during processing but doesn't
> appear on the wire.

OK, but you also don't like naked integers without documentation.
I can leave this as "xdr_stream_remaining() / 20" if you prefer.
Or we could define a macro somewhere that makes this code a little
more self-documenting.


> Also, that change isn't actually logically related to the rest of the
> patch, so it's the sort of thing I'd expect separated out.
>=20
> --b.

--
Chuck Lever



