Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558771EEE38
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2020 01:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgFDX1U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Jun 2020 19:27:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45530 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgFDX1T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Jun 2020 19:27:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054NMcd2105592;
        Thu, 4 Jun 2020 23:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=q3MC2FFVfqRFnY/t4c6lcCVH+ow63Y1vpfSVWqh2e5s=;
 b=H5pqIqPMYSAeys2pFVjbhkfkSXJPAvmDt3p1Pw1Nw/3YLTqgwi/C0rfPW3KE0+XQYmoz
 3w8bJJM6wonn02e+mXwpYN3sFYP5ziNDTUwVzBFhPNTe2j/cuoAkJO3JiNFkbkEjV4Rw
 SXU2ZnZWigxBjvsTD/lGEDzweUkY2w2dj1mYX4a+3DGUzFrt9KrDHRAhS8QXhO2TWpVq
 iFp5IzIu7dyYvjXUTlmDATfYsYa5ryvHPQ9bDzJpdPd3M66C2nDwmg5oB/vOZt++G/rG
 NJ49esLczW/6Jgj9lN4kgfAGrFXxoFnd42AbwhVKlBpm1ZsIqWbjslB9M5YoBAmw0FkQ xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31f91dr9d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 04 Jun 2020 23:27:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054NO8vX050011;
        Thu, 4 Jun 2020 23:27:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31f926ay5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jun 2020 23:27:15 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 054NRECD012510;
        Thu, 4 Jun 2020 23:27:14 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jun 2020 16:27:13 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH v2] mountstats: Adding 'Day:Hour:Min:Sec' format along
 with 'age' to "mountstats --nfs" for ease of understanding.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAC0K3iiJ3vdvAidLugYeCJGU669=tdd2a4Dj_iez2MVrWsdNfA@mail.gmail.com>
Date:   Thu, 4 Jun 2020 19:27:12 -0400
Cc:     Kenneth Dsouza <kdsouza@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>, smayhew@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2492F305-1173-4730-A4B2-EDAA4BE208A8@oracle.com>
References: <20200604175221.GA157967@fedora.rsable.com>
 <04942C45-9C31-424E-B5A1-C83553F786CE@oracle.com>
 <CAA_-hQKa6X1pqCoLkUjB+ApNxjWE3OapgxcSCL-B1b=npFefGQ@mail.gmail.com>
 <CAA_-hQLPDP208XriDoMBFEwnypPpEQJ_Tv5WSwDAbF_wW3fVFA@mail.gmail.com>
 <3A17F2AE-CFCA-46B9-8779-060FCCB911AF@oracle.com>
 <CAC0K3ih2GF6sxio70WMVxiO24e7xfRjVFfgScFSvYRSyjZ4+XQ@mail.gmail.com>
 <CAC0K3iiJ3vdvAidLugYeCJGU669=tdd2a4Dj_iez2MVrWsdNfA@mail.gmail.com>
To:     Rohan Sable <rsable@redhat.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 cotscore=-2147483648 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006040162
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 4, 2020, at 4:12 PM, Rohan Sable <rsable@redhat.com> wrote:
>=20
> >> For pretty-printing the mount point's age, you probably don't need
> >> to display the raw delta seconds value.
>=20
> Yes, I can drop that.
>=20
> >> Just wondering if there's a Python module that can do this for us?
>=20
> I was not exactly sure if I could be doing that, since this is kind of =
the 1st one for me.
> If that's fine, using the timedate module makes it way smaller and =
easier.

Importing "datetime" should be fine.


--
Chuck Lever



