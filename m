Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159432F69B0
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jan 2021 19:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbhANSga (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jan 2021 13:36:30 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43982 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbhANSg3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jan 2021 13:36:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10EIE0dd090600;
        Thu, 14 Jan 2021 18:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=2kPd0eoKcI0UXs8lpE42ku1jYkaE+GT70viuohVfAbU=;
 b=wwn28XUWAy6ZeRauPHRNL6wIusSSu33fZk83x4b2bVc73h5Q77JDH+hhtXiTZPxCsU8E
 oQTGKJXJ4d/6vzxjC7xfoCKoahM0PhnymLpv+h4N7y58HxHl9uZlI4OiACnXGXrX87m5
 huxoPvSC+8cSf6jU7129z1k0SHbQ1muJBv+1xphF12jPNGFMRKAyszRUuGvjueYTO0ti
 E7dJoWz4TO/OKawi2agpm0eapWWrf5VLupseBapbD1auGdp59yNHaMx90j/DCi13TbE4
 lR+Qkbs6RRVWCNrsUAEVMj2+t8PKCN5d4A+14nxZS7HEO01jxhFjlri8byEzU0ZuiaNR lA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 360kd01mf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 18:35:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10EIEsho150258;
        Thu, 14 Jan 2021 18:35:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 360kenkx2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 18:35:43 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10EIZcAQ015580;
        Thu, 14 Jan 2021 18:35:42 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jan 2021 10:35:38 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: nfsd vurlerability submit
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAHk-=wic1CEkj_vjf3dUWv41=aKeazSW5ugGOfYsKQZnihQhMw@mail.gmail.com>
Date:   Thu, 14 Jan 2021 13:35:37 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E14D32D-1B39-4DB1-AE39-B8B34655DC7D@oracle.com>
References: <20210108154230.GB950@1wt.eu> <20210111193655.GC2600@fieldses.org>
 <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org>
 <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
 <CAHxDmpTEBJ1jd_fr3GJ4k7KgzaBpe1LwKgyZn0AJ0D1ESK12fQ@mail.gmail.com>
 <96aea58bde3fe4c09cccd9ead2a1c85eb887d276.camel@hammerspace.com>
 <CAHxDmpTyrG74hOkzmDK834t+JiQduWHVWxCf_7nrDVa++EK2mA@mail.gmail.com>
 <74269493859fa65a7f594dadd5d86c74bd910e66.camel@hammerspace.com>
 <20210114180758.GB3914@fieldses.org>
 <CAHk-=wic1CEkj_vjf3dUWv41=aKeazSW5ugGOfYsKQZnihQhMw@mail.gmail.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9864 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101140107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9864 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140107
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jan 14, 2021, at 1:29 PM, Linus Torvalds =
<torvalds@linuxfoundation.org> wrote:
>=20
> On Thu, Jan 14, 2021 at 10:08 AM bfields@fieldses.org
> <bfields@fieldses.org> wrote:
>>=20
>> I dug around a bit and couldn't find the idea of using filehandle
>> guessing plus mountd's following of symlinks to get access to other
>> filesystems.  That's kind of interesting.
>=20
> [ Other people removed from cc, this is just a question about nfsd =
cleanliness ]
>=20
> I missed if Trond's suggestion to at least fix up ".." to have the
> same filehandle as "." for the top export directory was done.

If I understand your question correctly... there is a commit in
linux-next that simply doesn't return any filehandle for ".."
in the root directory.

=
https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=3D=
for-next&id=3D51b2ee7d006a736a9126e8111d1f24e4fd0afaa6

I intend to send you a PR after a few more days of soak time,
unless you'd like me to send it now.


--
Chuck Lever



