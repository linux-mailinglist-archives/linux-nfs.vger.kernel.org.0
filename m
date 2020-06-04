Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0C51EEA20
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2020 20:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbgFDSO3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Jun 2020 14:14:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38772 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729856AbgFDSO3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Jun 2020 14:14:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054IC10L158411;
        Thu, 4 Jun 2020 18:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=+KUjO2Hi03CSTfnSspBUFKq4n31U7pDWRMZf6wLyPTw=;
 b=GQADWMnynpDPZ7vZCmNtLfobLhWYdJMDxyGDscUVdlSnKka7rf9zIlDYh6dO+Y8O4fzI
 xPh0M3/j2UvJ0dos2dtG9njnQdjh9R5PuVP80mnKR4N39V5UY/zI+ryChgETOmzalxb+
 4u6Rf4YVMk9Ek4zSjY54TSXZ9TE9fzzommOHZzjdDoefk+aloFeRsOE4r0V9ocUTUBbn
 YMSf7LCZ0PdEFSHT9ORKAY7Lm8p6NS00J9Z2pPdhUMQLh0kKwF/NJz4f9g0pE1ollFPH
 isxwwxaMsWeTOLhEu2hvxLasnL13NRG2Oacn3wOg7bn7UnQj53tl1CahYIZX8LP3wZU/ JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31evvn2yff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 04 Jun 2020 18:14:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054I7aOQ147829;
        Thu, 4 Jun 2020 18:12:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31ej10scex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jun 2020 18:12:25 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 054ICONZ006257;
        Thu, 4 Jun 2020 18:12:24 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jun 2020 11:12:24 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH v2] mountstats: Adding 'Day:Hour:Min:Sec' format along
 with 'age' to "mountstats --nfs" for ease of understanding.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200604175221.GA157967@fedora.rsable.com>
Date:   Thu, 4 Jun 2020 14:12:23 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>, smayhew@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <04942C45-9C31-424E-B5A1-C83553F786CE@oracle.com>
References: <20200604175221.GA157967@fedora.rsable.com>
To:     Rohan Sable <rsable@redhat.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006040127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 suspectscore=0
 phishscore=0 clxscore=1011 malwarescore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040128
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 4, 2020, at 1:52 PM, Rohan Sable <rsable@redhat.com> wrote:
>=20
> This patch adds printing of 'Age' in 'Sec' and 'Day:Hours:Min:Sec' =
like below to --nfs in mountstats :
> NFS mount age: 9479; 0 Day(s) 2 Hour(s) 37 Min(s) 59 Sec(s)
>=20
> Signed-off-by: Rohan Sable <rsable@redhat.com>
> ---
> tools/mountstats/mountstats.py | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>=20
> diff --git a/tools/mountstats/mountstats.py =
b/tools/mountstats/mountstats.py
> index d565385d..c4f4f9e6 100755
> --- a/tools/mountstats/mountstats.py
> +++ b/tools/mountstats/mountstats.py
> @@ -233,6 +233,16 @@ Nfsv4ops =3D [
>     'COPY_NOTIFY'
> ]
>=20
> +# Function to convert sec from age to Day:Hours:Min:Sec.
> +def sec_conv(rem):
> +    day =3D int(rem / (24 * 3600))
> +    rem %=3D (24 * 3600)
> +    hrs =3D int(rem / 3600)
> +    rem %=3D 3600
> +    min =3D int(rem / 60)
> +    sec =3D rem % 60
> +    print(day, "Day(s)", hrs, "Hour(s)", min, "Min(s)", sec, =
"Sec(s)")
> +

Just wondering if there's a Python module that can do this for us?


> class DeviceData:
>     """DeviceData objects provide methods for parsing and displaying
>     data for a single mount grabbed from /proc/self/mountstats
> @@ -391,6 +401,8 @@ class DeviceData:
>         """Pretty-print the NFS options
>         """
>         print('  NFS mount options: %s' % =
','.join(self.__nfs_data['mountoptions']))
> +        print('  NFS mount age: %d' % self.__nfs_data['age'], end=3D"; =
")
> +        sec_conv(self.__nfs_data['age'])
>         print('  NFS server capabilities: %s' % =
','.join(self.__nfs_data['servercapabilities']))
>         if 'nfsv4flags' in self.__nfs_data:
>             print('  NFSv4 capability flags: %s' % =
','.join(self.__nfs_data['nfsv4flags']))
> --=20
> 2.25.4
>=20

--
Chuck Lever



