Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED4F1EEB35
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2020 21:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgFDTfC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Jun 2020 15:35:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44344 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbgFDTfC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Jun 2020 15:35:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054JWXsc125050;
        Thu, 4 Jun 2020 19:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=6rJ1NWGQh8EvtXsfh9L6LDYxWq5EC8R3GxfmUELsHWA=;
 b=ndZIPBoPd5dOo1AA1OHyhqZqHubo1xOP1OsLwgCshElgbuEqN6a1XK9oCErJAzioEAc6
 u4G36SSS/p8+ZEj5nPuFvwfLjK0ej1pf7t+42NFPfC89MMZLPM7yPzeELohM7rR2ABE/
 fr6jxlo/FcaiZPdLzwHithRb+SgUDAkGK3EflSJ/WVYXiGFRDR4GOORtriHDTj+JKlDU
 FavBBfMRZWIQxDo0Srsa+z3hFAADDdLbC0rm2jwirIAhCgVwTM90KS9vHZMn5GMzCfDr
 54r7uZni/cG+RxXMBG0lqDuv4J+eIObaJNP4ZSp23ayzaofsR/sqqDSlFLr7oAg3gq4I eA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31evap3g86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 04 Jun 2020 19:34:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054JS7S4139521;
        Thu, 4 Jun 2020 19:34:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31dju5gr01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jun 2020 19:34:56 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 054JYthD023015;
        Thu, 4 Jun 2020 19:34:55 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jun 2020 12:34:55 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH v2] mountstats: Adding 'Day:Hour:Min:Sec' format along
 with 'age' to "mountstats --nfs" for ease of understanding.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAA_-hQLPDP208XriDoMBFEwnypPpEQJ_Tv5WSwDAbF_wW3fVFA@mail.gmail.com>
Date:   Thu, 4 Jun 2020 15:34:54 -0400
Cc:     Rohan Sable <rsable@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>, smayhew@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A17F2AE-CFCA-46B9-8779-060FCCB911AF@oracle.com>
References: <20200604175221.GA157967@fedora.rsable.com>
 <04942C45-9C31-424E-B5A1-C83553F786CE@oracle.com>
 <CAA_-hQKa6X1pqCoLkUjB+ApNxjWE3OapgxcSCL-B1b=npFefGQ@mail.gmail.com>
 <CAA_-hQLPDP208XriDoMBFEwnypPpEQJ_Tv5WSwDAbF_wW3fVFA@mail.gmail.com>
To:     Kenneth Dsouza <kdsouza@redhat.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006040136
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 4, 2020, at 3:23 PM, Kenneth Dsouza <kdsouza@redhat.com> wrote:
>=20
> I get the below results using the datetime module.
>=20
> # mountstats --nfs | grep -w age
>  NFS mount age: 688865; 7 days, 23:21:05

For pretty-printing the mount point's age, you probably don't need
to display the raw delta seconds value.


> On Fri, Jun 5, 2020 at 12:23 AM Kenneth Dsouza <kdsouza@redhat.com> =
wrote:
>>=20
>> Using the datetime module?
>>=20
>> datetime.timedelta(seconds =3D n)
>> Should print in below format
>> 0:11:05
>>=20
>> On Thu, Jun 4, 2020 at 11:45 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>=20
>>>=20
>>>=20
>>>> On Jun 4, 2020, at 1:52 PM, Rohan Sable <rsable@redhat.com> wrote:
>>>>=20
>>>> This patch adds printing of 'Age' in 'Sec' and 'Day:Hours:Min:Sec' =
like below to --nfs in mountstats :
>>>> NFS mount age: 9479; 0 Day(s) 2 Hour(s) 37 Min(s) 59 Sec(s)
>>>>=20
>>>> Signed-off-by: Rohan Sable <rsable@redhat.com>
>>>> ---
>>>> tools/mountstats/mountstats.py | 12 ++++++++++++
>>>> 1 file changed, 12 insertions(+)
>>>>=20
>>>> diff --git a/tools/mountstats/mountstats.py =
b/tools/mountstats/mountstats.py
>>>> index d565385d..c4f4f9e6 100755
>>>> --- a/tools/mountstats/mountstats.py
>>>> +++ b/tools/mountstats/mountstats.py
>>>> @@ -233,6 +233,16 @@ Nfsv4ops =3D [
>>>>    'COPY_NOTIFY'
>>>> ]
>>>>=20
>>>> +# Function to convert sec from age to Day:Hours:Min:Sec.
>>>> +def sec_conv(rem):
>>>> +    day =3D int(rem / (24 * 3600))
>>>> +    rem %=3D (24 * 3600)
>>>> +    hrs =3D int(rem / 3600)
>>>> +    rem %=3D 3600
>>>> +    min =3D int(rem / 60)
>>>> +    sec =3D rem % 60
>>>> +    print(day, "Day(s)", hrs, "Hour(s)", min, "Min(s)", sec, =
"Sec(s)")
>>>> +
>>>=20
>>> Just wondering if there's a Python module that can do this for us?
>>>=20
>>>=20
>>>> class DeviceData:
>>>>    """DeviceData objects provide methods for parsing and displaying
>>>>    data for a single mount grabbed from /proc/self/mountstats
>>>> @@ -391,6 +401,8 @@ class DeviceData:
>>>>        """Pretty-print the NFS options
>>>>        """
>>>>        print('  NFS mount options: %s' % =
','.join(self.__nfs_data['mountoptions']))
>>>> +        print('  NFS mount age: %d' % self.__nfs_data['age'], =
end=3D"; ")
>>>> +        sec_conv(self.__nfs_data['age'])
>>>>        print('  NFS server capabilities: %s' % =
','.join(self.__nfs_data['servercapabilities']))
>>>>        if 'nfsv4flags' in self.__nfs_data:
>>>>            print('  NFSv4 capability flags: %s' % =
','.join(self.__nfs_data['nfsv4flags']))
>>>> --
>>>> 2.25.4
>>>>=20
>>>=20
>>> --
>>> Chuck Lever
>>>=20
>>>=20
>>>=20
>=20

--
Chuck Lever



