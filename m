Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7CD3376CF
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Mar 2021 16:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhCKPS6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Mar 2021 10:18:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60654 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhCKPSh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Mar 2021 10:18:37 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12BF8jAY015372;
        Thu, 11 Mar 2021 15:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8Hy1zDFdrSAl1BpkOvpvVp3ze/y+jH1PB757DSJrOIw=;
 b=A/dBDl55r7f8LkbUnsLw5+K+Mfqa49VhqxdpUW1MjFyzmmY59m74SMP+WTrwttE7EUng
 d7xTywNa95S6yLC2w+KHu6/mLyeahEvFNb6EAIWc6gBtOSHiHXKh2N/PHH7RCBQJgT38
 8gwg0Natrd8pSjc7wIFfWS1Yu9oYiwG7zNREMrJn3mvfXB/t6ZO16blA4wRgyUzRZ+Dm
 WbYbJZHCKG7pgrn7aFbQadSbb4oLJ3eLZ5dLD32z9Bl7xlTs1wUGRYvncKKYksvrLk3/
 /tgkJYXjfOMmJBhVvVir8MzCJFeJOjkeXhYZyPwAu7ZY5YdUXXbp+lQMlSeijBc5Zqri Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3741pmpx3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 15:18:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12BFBXQ8144099;
        Thu, 11 Mar 2021 15:18:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3030.oracle.com with ESMTP id 374kp13rbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 15:18:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Br4epyd7jcs/LE7TNGAcBo0CEyrbLKGWzBQmYSy7bcP1Tu+U7vSUugrJhpCO8I2v2fA/gEFDgDil975LhetAB4aule9AeP5GKXcNoJfAWU2fqYuuPD6RKnTM12TdlFGkSW3ASv5RJtZrTPFgpeuC7OuHcRZiD+G2iyW8bXGtuLH3sN/td21e38JblS/qO0QmwpKG621UoEUvRJFKI7O9Mn94yKgqcSYmanljjMU4wLsfKH4uLBEbzn/33WOhS7zP4b+QiwGv7HDPt8EYOH2V3ND0q9AsOLE053xO5o6+PIhazi73G0V3a36xn6QkKDfZ2EF5Qx0xdGTLZHmkiE2hnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Hy1zDFdrSAl1BpkOvpvVp3ze/y+jH1PB757DSJrOIw=;
 b=SO5ABWo5VEuByKP342zJSFz2glFJmIAk7S3dluYSy/+6RbEV4fHCNcdNhB21JS26Gmtyy9QgH4hPaYyEawslx6cPkRTbGjY4XTAdvJ8BuT/Qm5YQQWZGLIDrWYajVRSd5MY6UvwKppy1gfRSecZw6lKY+8XARU+I+kfHiZIKFNSk0lgVXtFZO0aS3ip6FYIGP67OkYZmF9uKBKsw871Xrfhom230V6GIPehhcI1vDyHySnIBRSL98WScoVrxE177wDd74rqbvE4f2dywkwD8o7HfOZq96F8gW7GTr590i42i9BWVf7xBppfCmFGKOW9VZc0IMyFflcMuZ+EfWI5CFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Hy1zDFdrSAl1BpkOvpvVp3ze/y+jH1PB757DSJrOIw=;
 b=ip572kFEi/jxUOCd1jKK1Om2IXxVZWLk4NkZyXDwav+dbKc4V/KKSRgNkUETL29CqHRt25MC9o499T5qab2cKqBWp7hQRf+5uH3JFAtUahgON0nH94TlVjFFxBqLP5y8YuE5tY0eZ6FYQ2adSmtb7tRP8DCvENKxEl91N7iX1d8=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4496.namprd10.prod.outlook.com (2603:10b6:a03:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 15:18:30 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 15:18:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Bruce Fields <bfields@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix error handling in callbacks
Thread-Topic: [PATCH 1/1] NFSD: fix error handling in callbacks
Thread-Index: AQHXFPJMATYPHlFtZkmEJfeeuT4DnKp7ykSAgABPzQCAAAVEgIAABRGAgAEqPYCAAHuCAIABHTUAgAABygCAAACLgA==
Date:   Thu, 11 Mar 2021 15:18:30 +0000
Message-ID: <FB84E90A-1A03-48B3-8BF7-D9D10AC2C9FE@oracle.com>
References: <20210309144127.57833-1-olga.kornievskaia@gmail.com>
 <YEeWK+gs4c8O7k0u@pick.fieldses.org>
 <4ca27c770577376b0a39f0cfcfb529b96d6d5aae.camel@hammerspace.com>
 <CAN-5tyFttTHRdnELORJwCER_KPGBNk4W3eLwG0Z=QkwmPQh1UQ@mail.gmail.com>
 <d205a6a77273534666b3c33065934b9f66e7b103.camel@hammerspace.com>
 <YEjb9ZadFqa9Vu9O@pick.fieldses.org>
 <CAN-5tyFZ8fS6fjOJEu2NkRYUX6HrA5XNKPWyWN+UVtQT6Gp4kQ@mail.gmail.com>
 <2BAF1E3E-6FDB-46FF-8A63-0CA7EE5B6535@oracle.com>
 <CAN-5tyEV0+DDgjXsfdiVhpeVNOprOmYQf24CdOCr+fayOmR3Bw@mail.gmail.com>
In-Reply-To: <CAN-5tyEV0+DDgjXsfdiVhpeVNOprOmYQf24CdOCr+fayOmR3Bw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85d04e35-e878-4813-6e08-08d8e4a0ed9d
x-ms-traffictypediagnostic: SJ0PR10MB4496:
x-microsoft-antispam-prvs: <SJ0PR10MB449615A4921A7304099DE21593909@SJ0PR10MB4496.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TXfUXVcA+oGpZSOX3PmvVXusnNPy8rE8vhSeQ2B1YnnTxv/ywAs0p1YOSdJzOX3Wd6fxp3aNexd57iXNksM652YQodWqC3iSIh1b9Y2ET7a6Ps52L6lQQ+/5FlKjxpLRATTa0lfcdG1wYxs75cRnYB2Q7fG8QyyYWBTEgIs0sjx3Tsb2G5rM3tsqR5hGsJ9mLAhN5/LNbmHg4uS1nndQzYyjBSlcBUxMb6yCX8jdGkRwhPSnQunCNDZ43DGOYstuTA+HWCjZ9x6YGd0MMf05d38/mPiBrurJSh26EJktRYWmZeM0NzygC/OKgMx8z2UGZwnixA7sMPxrWf1afS7cE8QdNhGbv1mWK+CgYpiBx1GnJZnDVKPgJTEg2LUWWuBYArJ7tVhyXUpbgiVuPpcNK8590LRVYTthicwRBK9m+1Ez7vp19SplSF81kbX9TxszMG6q3TUrOOaSDc+EOZf/LAzzRcaU+Aasi3sE0OO/OPBpcuD3Z8P9N7Jloh4dOPlJb1iv95WZ9v5wjOa5hqBXddxzRyCmMC0DFqykjjpmkHMS3JWl/Q5W+7QxO2gl3OFdb7Y3TzvfzeyS1Mwkh6jlmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(136003)(376002)(396003)(5660300002)(8676002)(33656002)(186003)(54906003)(2616005)(316002)(26005)(53546011)(8936002)(6506007)(2906002)(478600001)(6916009)(71200400001)(36756003)(83380400001)(76116006)(66446008)(91956017)(66946007)(66556008)(66476007)(64756008)(4326008)(86362001)(6512007)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iO6Uk9gciSBiV9/GtlnolE+sdAusgQKS2lJKuiBt3aSBArBxJ+LQ3yDZzpWo?=
 =?us-ascii?Q?VcAE9bU3gndlANua6ViFaiLvcT2eGNIwiaR4HN9+18JBwdy9bzh9L5vs0OMq?=
 =?us-ascii?Q?IzVFQN4YfIRDYIrWzHU9x/+VSIzTQ6dSOWqNI9mj/7P/DYiBPCfhvgw3DzwI?=
 =?us-ascii?Q?8LJ9CMEyfzWcxDlEjztFfHf/M1zlb0jvxMgjOsTBG4DqrW3rMhsC0rvgXL2S?=
 =?us-ascii?Q?3U7y3Jz+Vf2ROnt1bCdU71nW1il/iBiPmjhlGCYOR/Djabr8VLXrXgeJhl6T?=
 =?us-ascii?Q?MYPzoVIrtSpGqbBinH7XBoW3hVYurHL3/fvcA3OkM2VKVUc8+R/DCLKNLmNr?=
 =?us-ascii?Q?+HdrVsyomLBcw4n7tEwXGpRf6LZ6/g+KdGkEKTm/NPqAbsRwmPkcL317EsEY?=
 =?us-ascii?Q?4/kbB1+dm8JxtLa01Y1JC8rfZp59Q3rRatj0qWqIS0l+WOSdNMcQAIyByk/E?=
 =?us-ascii?Q?AXd245WeeTEGdw7QCFdBCI4BtGL0lS8JQm9J7ub2XvLKFzVx2jJRqpBA4UwG?=
 =?us-ascii?Q?+KoQak8W//gbuT0IS0hlXcBAvzyQTd+5mtPzaPDA78BivgwOkr0nLADDoMx7?=
 =?us-ascii?Q?no7gGhvawPJFGVby5PqaiIytm01P8FI4qT996e2wuAKU3OqRrQjl8lYzIO4q?=
 =?us-ascii?Q?GaNJ2Ifdo45wqJq+VA2/zpMCn5RjelqpFt91IjV9JZitFHni3dhfcjnyTQze?=
 =?us-ascii?Q?WI+bAzGNimCOn8cZhGgmPgK0h3TokEkibNSnxp3htYUthZgGafuPBN9GvqPI?=
 =?us-ascii?Q?MBjOMrOtFAhLsZI1NZl4JOAcPb4nJ68kSjF6RqyOqN6G/YdOeWgAR5hBRNMN?=
 =?us-ascii?Q?l65rxpibLATdEvtzrBemJEci0y0voZOKNEAo20oQZa+lZQO2qEb3bULJcjt4?=
 =?us-ascii?Q?BIfI7TnYGgJTXBCUGRH/7ajSf347ehJ7+B3GNH+bgu8LmRlJm1eje1ZXDBAH?=
 =?us-ascii?Q?GxTi8uY7sIG2jCqiZmtdze/ZHdQh8eJzNQtHURtdhTMDdI0iahdMQK6CZWwF?=
 =?us-ascii?Q?tVlXA6s3aG2Flu9S8ku6doLMXHx5GMzFRRk4i2LpjUFaO355aHZfdebfVWjS?=
 =?us-ascii?Q?T/ceIY8s1U9ySkoSUpo+0Aggc5ljYPDK0FXhpCpzD2G7misJ5HpZs67Bhnpq?=
 =?us-ascii?Q?e99aIbYPDpriUvhzPnAqJduq7da6MEF37PVedUNFqrixiGOMVmlIqJYUgizd?=
 =?us-ascii?Q?ooIHMV4xav5ddEx2kuLuprilfzSRhP7hYXYTx23f7kOVBzCTyK6ZlKIR76Ln?=
 =?us-ascii?Q?98GZeBsIWuUpNa1DCpVgklidDJ3ajXHCCbsNs6xL2lV5Abyr86XgIC/Oy6cb?=
 =?us-ascii?Q?Ui2PPK4FHLl0sz9FXkSHNy4G?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B762FDA926C1294DB392AC76EC16748E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d04e35-e878-4813-6e08-08d8e4a0ed9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 15:18:30.4506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mtye8xFFK5H5CcoXYa/lDGTGeC7gEVyHYInckfjnjurlNlTOXJ8gYVcjzh6/3Hlc29qhKXFRshz8jmJF7Iv4FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4496
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110083
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110083
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 11, 2021, at 10:16 AM, Olga Kornievskaia <olga.kornievskaia@gmail.=
com> wrote:
>=20
> On Thu, Mar 11, 2021 at 10:10 AM Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>>=20
>>=20
>>=20
>>> On Mar 10, 2021, at 5:09 PM, Olga Kornievskaia <olga.kornievskaia@gmail=
.com> wrote:
>>>=20
>>> On Wed, Mar 10, 2021 at 9:47 AM J. Bruce Fields <bfields@redhat.com> wr=
ote:
>>>>=20
>>>> On Tue, Mar 09, 2021 at 08:59:51PM +0000, Trond Myklebust wrote:
>>>>> On Tue, 2021-03-09 at 15:41 -0500, Olga Kornievskaia wrote:
>>>>>> On Tue, Mar 9, 2021 at 3:22 PM Trond Myklebust <
>>>>>> trondmy@hammerspace.com> wrote:
>>>>>>>=20
>>>>>>> On Tue, 2021-03-09 at 10:37 -0500, J. Bruce Fields wrote:
>>>>>>>> On Tue, Mar 09, 2021 at 09:41:27AM -0500, Olga Kornievskaia
>>>>>>>> wrote:
>>>>>>>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>>>>>>>=20
>>>>>>>>> When the server tries to do a callback and a client fails it
>>>>>>>>> due to
>>>>>>>>> authentication problems, we need the server to set callback
>>>>>>>>> down
>>>>>>>>> flag in RENEW so that client can recover.
>>>>>>>>=20
>>>>>>>> I was looking at this.  It looks to me like this should really be
>>>>>>>> just:
>>>>>>>>=20
>>>>>>>>       case 1:
>>>>>>>>               if (task->tk_status)
>>>>>>>>                       nfsd4_mark_cb_down(clp, task->tk_status);
>>>>>>>>=20
>>>>>>>> If tk_status showed an error, and the ->done method doesn't
>>>>>>>> return 0
>>>>>>>> to
>>>>>>>> tell us it something worth retrying, then the callback failed
>>>>>>>> permanently, so we should mark the callback path down, regardless
>>>>>>>> of
>>>>>>>> the
>>>>>>>> exact error.
>>>>>>>=20
>>>>>>> I disagree. task->tk_status could be an unhandled NFSv4 error (see
>>>>>>> nfsd4_cb_recall_done()). The client might, for instance, be in the
>>>>>>> process of returning the delegation being recalled. Why should that
>>>>>>> result in the callback channel being marked as down?
>>>>>>>=20
>>>>>>=20
>>>>>> Are you talking about say the connection going down and server shoul=
d
>>>>>> just reconnect instead of recovering the callback channel. I assumed
>>>>>> that connection break is something that's not  recoverable by the
>>>>>> callback but perhaps I'm wrong.
>>>>>=20
>>>>> No. I'm saying that nfsd4_cb_recall_done() will return a value of '1'
>>>>> for both task->tk_status =3D=3D -EBADHANDLE and -NFS4ERR_BAD_STATEID.=
 I'm
>>>>> not seeing why either of those errors should be handled by marking th=
e
>>>>> callback channel as being down.
>>>>>=20
>>>>> Looking further, it seems that the same function will also return '1'
>>>>> without checking the value of task->tk_status if the delegation has
>>>>> been revoked or returned. So that would mean that even NFS4ERR_DELAY
>>>>> could trigger the call to nfsd4_mark_cb_down() with the above change.
>>>>=20
>>>> Yeah, OK, that's wrong, apologies.
>>>>=20
>>>> I'm just a little worried about the attempt to enumerate transport lev=
el
>>>> errors in nfsd4_cb_done().  Are we sure that EIO, ETIMEDOUT, EACCESS i=
s
>>>> the right list?
>>>=20
>>> Looking at call_transmit_status error handling, I don't think
>>> connection errors are returned. Instead the code tries to fix the
>>> connection by retrying unless the rpc_timeout is reached and then only
>>> EIO,TIMEDOUT is returned.
>>>=20
>>> Can then my original patch be considered without resubmission?
>>=20
>> Bruce has authorized v1 of this patch, but that one has the
>> uncorrected patch description. Post a v4?
>=20
> v1's description is accurate. It reflects that only authentication
> errors are handled.

Nit: The short description isn't specific to NFSv4.0, as the v3
one was.


>>>> --b.
>>>>=20
>>>>>=20
>>>>>>=20
>>>>>>>>=20
>>>>>>>> --b.
>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>>>>>>>> ---
>>>>>>>>> fs/nfsd/nfs4callback.c | 1 +
>>>>>>>>> 1 file changed, 1 insertion(+)
>>>>>>>>>=20
>>>>>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>>>>>>> index 052be5bf9ef5..7325592b456e 100644
>>>>>>>>> --- a/fs/nfsd/nfs4callback.c
>>>>>>>>> +++ b/fs/nfsd/nfs4callback.c
>>>>>>>>> @@ -1189,6 +1189,7 @@ static void nfsd4_cb_done(struct rpc_task
>>>>>>>>> *task, void *calldata)
>>>>>>>>>               switch (task->tk_status) {
>>>>>>>>>               case -EIO:
>>>>>>>>>               case -ETIMEDOUT:
>>>>>>>>> +               case -EACCES:
>>>>>>>>>                       nfsd4_mark_cb_down(clp, task-
>>>>>>>>>> tk_status);
>>>>>>>>>               }
>>>>>>>>>               break;
>>>>>>>>> --
>>>>>>>>> 2.27.0
>>>>>>>>>=20
>>>>>>>>=20
>>>>>>>=20
>>>>>>> --
>>>>>>> Trond Myklebust
>>>>>>> Linux NFS client maintainer, Hammerspace
>>>>>>> trond.myklebust@hammerspace.com
>>>>>>>=20
>>>>>>>=20
>>>>>=20
>>>>> --
>>>>> Trond Myklebust
>>>>> Linux NFS client maintainer, Hammerspace
>>>>> trond.myklebust@hammerspace.com
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



