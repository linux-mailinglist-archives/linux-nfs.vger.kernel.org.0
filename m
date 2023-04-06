Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151BB6D9C8F
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 17:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239793AbjDFPkx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 11:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjDFPkw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 11:40:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A1D12E
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 08:40:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336F98rW002659;
        Thu, 6 Apr 2023 15:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rWXfWz5AXzbl6ZjQupKDyjXb+e53kAPdn/f+SlLav6s=;
 b=BT+Z+6Ta55S8k1rpJLyt4WHG/yTA/01XDhIKnxwafmDUgEygfhlVxmOMRsPskJuzSits
 eH35ZFXwBLpLwOBvenWheqeQZmHq/XaDYIkrCOZwCJm6Uzr6S/1OpU4WQJH8NN7R8YKR
 B6kCF4MQj+PBH94BUgdTrdqWlpYtmjJU549ZBMCFRo2iRLR7y9f82/vX0EHBLkMOShHf
 XHaIU6eeliMUSKuafgWD/N/t5r81lF7dL4a1Y+i+W8gzIGyHuKVVleCY93ZxCad1qWY1
 PXekuoBMXjzHG3FtqOWrNYgEH/PRuapDqLravRxG73AI77MrWwYXK6pPcknDfh8Xxbhq 5w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcgau5bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 15:40:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336FE3h4034189;
        Thu, 6 Apr 2023 15:40:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjvf01e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 15:40:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTRxvordwShNfx4gXLTvSO4a4Fn4tzjqBlpLQM6hBX4kEjnS5hSqhIlsaJvXEIB/VuX3wAAofHrx2kCVeCg9NgiUC3zmrOPauSAbigEAtk3P0yXUuWpNBIL0U/DxqEzotnPtwvzKZ0IYQ6vXof5suSw6dnBLovUydphUTGWg5t0qOL7Xf+omjNkrJU1zCDHnXO/xFQvHphUlw9JNbUvXglrQ+FR7dr1qRVSvwS9YaIRB1hvRjzw1iXSFULIeAysS9vnHB2lKmOoJf5JK8nXdUvjRpnmB0lljDIzmaV9sLVpys8hDF1yfYCmNP0WDf8cXJjQ9nZjb5rz/enqnJqLJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWXfWz5AXzbl6ZjQupKDyjXb+e53kAPdn/f+SlLav6s=;
 b=Xf/PsHoryQmc/GawjBhnmwxTjZDP66gTsSQzt8l76U3vnmcCrGoeogFj9tWWdH9OgfWpm1nRdMZOByLQECcRrbgnAcLtYbeelEccXLbM+YPkZnMSquDN4Wblw735r9ToqmzptR8aOETfxF8N8M4qijtQcZP3igcm4x9mgOaDw1SForfjMj8w5se69pfSn3/BXWL4m4p6TmyWkNH2twW6kzSoR+ogjuKGvC1XgucO9WrhZz+tGt5RhcIa6z+iiBJs/mQwDkesBqHv3Z3xhPJXmMjevOJ1RYf7icb44Y74P9V/KF5w8yni+QDeZQjuTBxClWISTy28dLdotE3EVI56qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWXfWz5AXzbl6ZjQupKDyjXb+e53kAPdn/f+SlLav6s=;
 b=ZEk5eCb0RQiu52r68gwItguUW+qCL2ARD5IhztY/nopYbII/2nWH9zA3UUM4a/0dd6MiEITsJ0Fz1tt6YRdF7P9W2d0kdu9LCxrwED6bYFe1KB5+fDXc2N5m9WtbyAHGP6HrKZj8kQ++/+2gO79BUf8y19V9ylK3MdEXdRx/cS8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Thu, 6 Apr
 2023 15:40:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 15:40:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christian Herzog <herzog@phys.ethz.ch>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: file server freezes with all nfsds stuck in D state after upgrade
 to Debian bookworm
Thread-Topic: file server freezes with all nfsds stuck in D state after
 upgrade to Debian bookworm
Thread-Index: AQHZaHlTRrbt4X56/UeV6X78Hvk59K8eS9UAgAAdagCAAAIMAA==
Date:   Thu, 6 Apr 2023 15:40:42 +0000
Message-ID: <478CD009-C11B-46F2-AD13-689953D612ED@oracle.com>
References: <ZC6oX7FxdJd86rF7@phys.ethz.ch>
 <6785EFE7-2CE1-45CD-8643-C40CCCDADEB8@oracle.com>
 <ZC7mOH4I3roIM4xr@phys.ethz.ch>
In-Reply-To: <ZC7mOH4I3roIM4xr@phys.ethz.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4370:EE_
x-ms-office365-filtering-correlation-id: b7944db7-5f8e-403e-eb32-08db36b547dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pOPc9LxSFMQS8RS1dQnqYd45o/vKw6Lc2DsYOfrN0Rvh+0XDkjxA2+Hj56RKV4gMYjNbZAGB/Ze8LIPehSTIhUC7P5DUUR7HHyqw8qKIszaPvLWIORyy5mP0qzr3wuB2lprCvN1U6WItPmEC8prG/G3m8qu1+YK+/1RPQQPhApSdkyaf5tqZdFLghKuwfe8opMnAkn2tgy4omGnmT3jxVOdvvk+i6dZfh821z2WAaqODjpQAOQk+f+WZgv5Ke1b57QEz5JI2K3asmPiuFFxjD8TpP1lrs7vK91w1CxeIlbWmwWW/lVVNFIxQ5rWrlAQVyV7WSuf49u1fW+i6HTMRs9uERBp3P0MJNIg3hD+KBORiMuXuJVdOPAMHAVv1HgjpvgdOu/mEf5cWTm11k/VRZGCgbmCn/w00FkOgI22Dz4Swjl1WOuK+esrMGKAMN1TLp3Tr8OSSK1QBnU65StxdqtQPcvwWPX6VC05CZ4U2M1Vk2GPUbwq60ZUgINN0O4QG8DRq83mFd7xKat7eq2VOFn97I2JIbNoSHOCwIcof+BtC6QfsDKeBSxDk3C7uAUA7WRCeNXNyv8iAH2hoX1UakevFrn+9IrOJz4W0al3xeX2y6j+xI/oJMb/+S8CQKcELYEPSxyaExBvYJBfzq9Wugg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(2616005)(83380400001)(91956017)(6486002)(71200400001)(186003)(6512007)(478600001)(316002)(53546011)(6506007)(26005)(2906002)(6916009)(4326008)(41300700001)(33656002)(5660300002)(36756003)(66446008)(66556008)(8676002)(122000001)(66476007)(76116006)(38070700005)(66946007)(86362001)(64756008)(8936002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vAVCP8jTPt0793rUgMfYnc5fIZ1qxXB+18ZvwuwMM17B5+8kniLuyUW89NEg?=
 =?us-ascii?Q?OVa2t9T2XlZOEPT3h3XnpFdKAlgfmCVWnbG2UKbZqcBEKSI7mAfgBvqkjNrG?=
 =?us-ascii?Q?EACbXZW6AKAddZ61vk/KJrhXZJmt/fjLj1cpccMWRMVS7acTXa+/V02+Mf5W?=
 =?us-ascii?Q?vDWoEXJlFxa6LNYTxHPs+tsTcR/pyJCcLRDgHg84lMgbTYHbMYahvvC51qoy?=
 =?us-ascii?Q?OKJ6GtFlWXIJyfdPZjERnY3L01cQLOl7G5b9gD8m0osXg6Y1D4fYP5JRB9CJ?=
 =?us-ascii?Q?qGLs2/H5OJyCMPlTP9heZ7lUGerfeb2x4HGN2Of5WqXlNtOfm24HXKLtYXMm?=
 =?us-ascii?Q?TXszSI9v7ojmRtz5c7dfJfhkw3pvWdqQ/8QRAROtnYNnpHHO/2Tt4qWXRb03?=
 =?us-ascii?Q?46xSmhfvUxSQTjoNyuxA8IZsj+kEaLhwgv2nIqAds0mDr0SP4u/tjkBcE6hP?=
 =?us-ascii?Q?X35oCVKLOIz3g8/CqJLKI2ukh5WgyTWgu/j7KRpXhhhfII36+VDPYUCnfwEi?=
 =?us-ascii?Q?2Y55BNr7s5K54cGpfsQiknaXp+DEGCCdRVSY8uyD3rOPuuDLUIZN4PjjIl9L?=
 =?us-ascii?Q?gakdCU99stzNtIgdz3U9oqlWtfVuGBVRs6Yh7yUc1zaoA/kAYWlVcxPVqBU3?=
 =?us-ascii?Q?ZzYC1OHBc4pIWlWusJazwYHatXOD8kNGViljiTm3O1FBp78ahdMR5AnZ4OUp?=
 =?us-ascii?Q?63v+ikwSTIgEM7ECZMh2eey/irvA0lN7mQwBhKeiYOTCztUoxTBQeSt4xjS+?=
 =?us-ascii?Q?8cIBNSwXhisvpU9djFA9R4qjaGMHOMCJBp8D7sGo+VwMBhKizwcS7cRAg7zo?=
 =?us-ascii?Q?hVSnvSRJlAfwwS1kgxb1xbNg9alIPPHKSL8/Mtl16465sBBwkAvnuctSjOXV?=
 =?us-ascii?Q?JfSisMS8AIus2Hy4QEaIdvsbue2cmj46hw2ZXwLgKtANMW+FV+s3YKokR8y5?=
 =?us-ascii?Q?dcOsTA+w0c0lfS++/ZVfPjfq9MfXy4fr+ma5clvsmAo+ZWKFldzWywOwFHiQ?=
 =?us-ascii?Q?78KkKeuXtmkRuZlJwboZ0Cvtxvx3fLc2rvb9xB1IBN5aGDcE0G8NWv0u+cNF?=
 =?us-ascii?Q?wk9HmweDau2W3+Y1NK19SheFB69vL6zLKd+8sXEbyRp7kOfCuZKgl7SwA0Dg?=
 =?us-ascii?Q?MtFkEv/JHs0QCDAvC9sjjxaSWEkF1f/oqwcXYTdxasPay+/RDO4poB1rvuVk?=
 =?us-ascii?Q?xwBAdld+opimTOPwdz4SPHVCJHmgn/bOe3T6SDKJYA6PYiI+BJZuk4p9W48P?=
 =?us-ascii?Q?FPxtSn8Bgy7VWVbhmcuTQsEFt2DMs9yCNHqwYV/dKEPSLBLNhyH9izjhqJfS?=
 =?us-ascii?Q?QaR1I5A9euhW8dDCnXCY5y5ZuPOIQm+685GK/5SZ1YgHDY/AAa2FdW8RsY4q?=
 =?us-ascii?Q?yetZZX0mKq79+dLouQqL7LKn7Dx9JJ41zDvBmyWnntfrrLJYairbFUEMg5Mj?=
 =?us-ascii?Q?xHvhPLotaZ9yKgr8V1bvtPBAhJrNh28GUZgXHI4yrvkILZsgShgyocQz+BIE?=
 =?us-ascii?Q?6CSgqH+6DXpJhXKJqIuLuWgJiHtbhGbH0HWEuByVrRhueU6zEJ8OrIunzvFe?=
 =?us-ascii?Q?KQ8w6lX/IIjUoKGFnk0BU4g6UM8TmH5P70jLRXH2sbVSM6ylAcJnB5eco+tB?=
 =?us-ascii?Q?Bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA0548E4C9C4534B95D46A9195405400@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XB+k5NHXkkb7e1DNyybQWuijGgcE+jzoIKb+gLL3AcbKF6Q8CrTBo31o+IsR/pWFeE5P6mP9/jU1IPTDdof8VJc8uqmv/kTjaHK/x7QoZYwE//+Ix/29i2ruPj0zHlUeNOfngRCrULaCIXjTtmNt7fzwZwguUU8VESu64QiP8jvk58+9R8xILcRoLsDjbBXQgOFKKHByYJt6t/Xu/NNfF2lTR04axt1T66UDm7UTwxWJShI2iMLKBDJTUzRERwSSOFoI1UJryYNhSecTY82bQoBemVzB2tFTMN0LGQnIbSrqZ6wUFnGUJzuaYjh5uo8TUuESYJ4hwPB9S59/5pIEqQY4lFXU35gVlSTo8wwZGnF8TtOo2eab0e+UziP18fyzEDSWkg4apeRJ8djl/Qk4JHKNyf57qAwbwl09/qvF6a/CGXBm99e3LWJPFKY6mIrwPIvNosha3pQbvBA2Bv/slElfaLwtQd9TtBzn/o5/jjv2v9k/B0x7+7U67qIN4OGqND4Q/HDIkWsdXJNryy1vXhbR2j5Z7/69plMfpFD1rpLBW0ohPXNIU+1lmXvXxTSLpIM1vT0GriP0LP8HPVXpWtAoQU9XLlBraMZyvpQZ3wWGwSXzqyGjvVRrQ+SY6Dg0D9gnvFTY+UzgcLk0t9OIG359FeUekjP6e+YJmFiXS82Zyvy/kW3Qx6q6zZpgREOed7JvNJ1T067DquawVWc+4agjR0w11tv/QqkJTmhAUQpq36Yz5qfujZkVTF53y4I1gAcLqnHagpQC5FD+l0pztOgyw1Z+J74vFHHbmD0PumA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7944db7-5f8e-403e-eb32-08db36b547dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 15:40:42.5555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBLQRhm0D6UyD4OxzGRJWrpTLQXaGKYRlhHC/TOjynKc4LGlyzZ8cCRh+YultMu0wP1AQ8nFcyrb9OSUs7FFsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_09,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060139
X-Proofpoint-GUID: u4gLWJ_Hl2WYM7iSnh88tp_F_XKx2nT0
X-Proofpoint-ORIG-GUID: u4gLWJ_Hl2WYM7iSnh88tp_F_XKx2nT0
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 6, 2023, at 11:33 AM, Christian Herzog <herzog@phys.ethz.ch> wrote=
:
>=20
> Dear Chuck,
>=20
>>> for our researchers we are running file servers in the hundreds-of-TiB =
to
>>> low-PiB range that export via NFS and SMB. Storage is iSCSI-over-Infini=
band
>>> LUNs LVM'ed into individual XFS file systems. With Ubuntu 18.04 nearing=
 EOL,
>>> we prepared an upgrade to Debian bookworm and tests went well. About a =
week
>>> after one of the upgrades, we ran into the first occurence of our probl=
em: all
>>> of a sudden, all nfsds enter the D state and are not recoverable. Howev=
er, the
>>> underlying file systems seem fine and can be read and written to. The o=
nly way
>>> out appears to be to reboot the server. The only clues are the frozen n=
fsds
>>> and strack traces like
>>>=20
>>> [<0>] rq_qos_wait+0xbc/0x130
>>> [<0>] wbt_wait+0xa2/0x110
>>=20
>> Hi Christian, you have a pretty deep storage stack!
>> rq_qos_wait is a few layers below NFSD. Jens Axboe
>> and linux-block are the folks who maintain that.
> are you saying the root cause isn't nfs*, but the file system?

I can't possibly know what the root cause is at this point.


> That was our first idea too, but we haven't found any indication that thi=
s is the case. The xfs file systems seem perfectly fine when all nfsds are =
in D state, and we can
> read from them and write to them. If xfs were to block nfs IO, this shoul=
d
> affect other processes too, right?

It's possible that the NFSD threads are waiting on I/O to a particular file=
system block. XFS is not likely to block other activity in this case.

I'm merely suggesting that you should start troubleshooting at the bottom o=
f the stack instead of the top. The wait is far outside the realm of NFSD.


--
Chuck Lever


