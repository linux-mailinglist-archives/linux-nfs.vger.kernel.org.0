Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A24F2CDBAC
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 18:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgLCRBC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 12:01:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47148 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgLCRBB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 12:01:01 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3Gn4dG126944;
        Thu, 3 Dec 2020 16:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8MD/B4pPwb0ghK1S03ICNTSrZpfvIwmawNeZToU17yI=;
 b=PaKTGsnTGDhzQlwVDl3norU/P8rs9zmQz0kCWXfwwKK4suHtlVDJjnGTxYHjN2mEzaLi
 E6fIhqyVGj5QPZquM25i7ubP7IIG/o2JN5xFF1zpkv8tIWG9OYYyLr5RFw1FZ7B9cJQa
 t12QDSIRho/yQO9Xy7+bAYYFcwMaWJBNUbuwNg+fHOSCcqT45yhh6I/CshSqHumXF2PI
 ScAHBAgpzESOZGqjbss0kv46OGq/tHQmURWyhCU3q4URcy6czRPVuSGs09nFSX9H07B8
 WPrB3Tuaeu1DbKIF5VP63KzWq6z7cNJWv/S6IoPMgHwC5M9H+jB0CvCP1tNpuKsG8b/l 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 353c2b768w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Dec 2020 16:59:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3GoEFg081074;
        Thu, 3 Dec 2020 16:59:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3540f242r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Dec 2020 16:59:59 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B3GxrXN027818;
        Thu, 3 Dec 2020 16:59:56 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219) by default
 (Oracle Beehive Gateway v4.0) with ESMTP ; Thu, 03 Dec 2020 08:59:38 -0800
MIME-Version: 1.0
Message-ID: <338C33D2-A5F2-40D0-9D8B-6E6334D361A8@oracle.com>
Date:   Thu, 3 Dec 2020 08:59:37 -0800 (PST)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>,
        Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        trondmy <trondmy@hammerspace.com>
Subject: Re: Kernel OPS when using xattr
References: <2137763922.1852883.1606983653611.JavaMail.zimbra@desy.de>
 <CAN-5tyEWYqXiqLdJE-DLH2b+LrVfPkviJDGQY=MyitS5aW4bJw@mail.gmail.com>
 <1296195278.2032485.1607010192169.JavaMail.zimbra@desy.de>
 <20201203161858.GA27349@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
In-Reply-To: <20201203161858.GA27349@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030100
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 3, 2020, at 11:18 AM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> On Thu, Dec 03, 2020 at 04:43:12PM +0100, Mkrtchyan, Tigran wrote:
>>=20
>> Hi Olga,
>>=20
>> Franks patches are not applied. I will check with Trond's patch and
>> then will try those as well.
>>=20
>> Regards,
>>   Tigran.
>=20
> Since my change no longer uses SPARSE_PAGES, it'll probably avoid the
> oops, so give it a try.
>=20
> Having said that, fixing SPARSE_PAGES seems like a better option.. My
> ideal outcome would be to have a working SPARSE_PAGES for all =
transports.
> That would allow GETXATTR and LISTXATTRS to just always specify a max
> size array of pages, giving it maximum flexibility to cache the =
received
> result no matter what, and avoiding allocations that are too large.

SPARSE_PAGES (at least for RDMA) always allocates the full set of
pages, because it has to set the receive buffer up before the request
is sent and it has no way to know the actual size of the reply.=20

There is really no savings when the transport does it, and it is less
reliable because the transport runs in a context where GFP_KERNEL
allocations are not allowed.


> For now, though, I'm happy with the v2 patch I sent in.
>=20
> - Frank

--
Chuck Lever



