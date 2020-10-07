Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FEB286104
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 16:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgJGOPu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 10:15:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60670 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgJGOPu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 10:15:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097EFVQd066565;
        Wed, 7 Oct 2020 14:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=OUTx0+SDTZgUE4q1Ya/E45pXtGg4A7DnacTIyqlZ27A=;
 b=rb/ONmreVkZevObMV8zXMl6d3WVO5ndMIcAeXWynsgKkYgdXWCWGFSKJ0thGz1KzRxgB
 /oecU4wWkCnpZ21u7zNFfDw/+uEifz/361wwrF1QmsdtbvuaJ1hgKjOARiLAmCXve8Pp
 X4bfjPYv5TEfVZ35PXB74yEXOF+Uf1QmFj91bg0fAm4BHGZNW2CszZiMBg57bHLnwrqt
 /WGju14fSjazMDMXNbuO7lCyeSteuDIApJ4fUVFPFzZyW4NCMB1bldRDKYCfQsqVPBhV
 V0oX1+uGZVU3O2qML59r6n07I1mJjjb8dwbZV5DW1FtABjwnyzDyEtrNyifN7QZb9e45 Og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33xhxn1x73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 07 Oct 2020 14:15:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097EErX4082429;
        Wed, 7 Oct 2020 14:15:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3410jypmv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 14:15:43 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 097EFfAt027406;
        Wed, 7 Oct 2020 14:15:41 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Oct 2020 07:15:41 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: unsharing tcp connections from different NFS mounts
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201007140502.GC23452@fieldses.org>
Date:   Wed, 7 Oct 2020 10:15:39 -0400
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
References: <20201006151335.GB28306@fieldses.org>
 <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
 <CAN-5tyGDC0VQqjqUNzs_Ka+-G_1eCScVxuXvWsp7xe7QYj69Ww@mail.gmail.com>
 <20201007001814.GA5138@fieldses.org>
 <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
 <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>
 <8ED5511E-25DE-4C06-9E26-A1947383C86A@oracle.com>
 <20201007140502.GC23452@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070091
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 7, 2020, at 10:05 AM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Wed, Oct 07, 2020 at 09:45:50AM -0400, Chuck Lever wrote:
>>=20
>>=20
>>> On Oct 7, 2020, at 8:55 AM, Benjamin Coddington =
<bcodding@redhat.com> wrote:
>>>=20
>>> On 7 Oct 2020, at 7:27, Benjamin Coddington wrote:
>>>=20
>>>> On 6 Oct 2020, at 20:18, J. Bruce Fields wrote:
>>>>=20
>>>>> On Tue, Oct 06, 2020 at 05:46:11PM -0400, Olga Kornievskaia wrote:
>>>>>> On Tue, Oct 6, 2020 at 3:38 PM Benjamin Coddington =
<bcodding@redhat.com> wrote:
>>>>>>>=20
>>>>>>> On 6 Oct 2020, at 11:13, J. Bruce Fields wrote:
>>>=20
>>>>> Looks like nfs4_init_{non}uniform_client_string() stores it in
>>>>> cl_owner_id, and I was thinking that meant cl_owner_id would be =
used
>>>>> from then on....
>>>>>=20
>>>>> But actually, I think it may run that again on recovery, yes, so I =
bet
>>>>> changing the nfs4_unique_id parameter midway like this could cause =
bugs
>>>>> on recovery.
>>>>=20
>>>> Ah, that's what I thought as well.  Thanks for looking closer Olga!
>>>=20
>>> Well, no -- it does indeed continue to use the original cl_owner_id. =
 We
>>> only jump through nfs4_init_uniquifier_client_string() if =
cl_owner_id is
>>> NULL:
>>>=20
>>> 6087 static int
>>> 6088 nfs4_init_uniform_client_string(struct nfs_client *clp)
>>> 6089 {
>>> 6090     size_t len;
>>> 6091     char *str;
>>> 6092
>>> 6093     if (clp->cl_owner_id !=3D NULL)
>>> 6094         return 0;
>>> 6095
>>> 6096     if (nfs4_client_id_uniquifier[0] !=3D '\0')
>>> 6097         return nfs4_init_uniquifier_client_string(clp);
>>> 6098
>>>=20
>>>=20
>>> Testing proves this out as well for both EXCHANGE_ID and =
SETCLIENTID.
>>>=20
>>> Is there any precedent for stabilizing module parameters as part of =
a
>>> supported interface?  Maybe this ought to be a mount option, so =
client can
>>> set a uniquifier per-mount.
>>=20
>> The protocol is designed as one client-ID per client. FreeBSD is
>> the only client I know of that uses one client-ID per mount, fwiw.
>>=20
>> You are suggesting each mount point would have its own lease. There
>> would likely be deeper implementation changes needed than just
>> specifying a unique client-ID for each mount point.
>=20
> Huh, I thought that should do it.
>=20
> Do you have something specific in mind?

The relationship between nfs_client and nfs_server structs comes to
mind.

Trunking discovery has been around for several years. This is the
first report I've heard of a performance regression.

We do know that nconnect helps relieve head-of-line blocking on TCP.
I think adding a second socket would be a very easy thing to try and
wouldn't have any NFSv4 state recovery ramifications.


--
Chuck Lever



