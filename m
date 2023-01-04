Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEBE65DBFF
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 19:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbjADSSu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Jan 2023 13:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240202AbjADSGu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 13:06:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD288140FC
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 10:06:48 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304FNrRd018995;
        Wed, 4 Jan 2023 18:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=HSsEfCHNYxA79Ekbd/qpN4PHkOgDNNIIAz5RdJOkBYI=;
 b=LWIAwePupjfpgvFO1xTLbyg1UlteBMvYhq46WEwP72Odp1dKJphXI6AiKXG2wV8Crz2M
 FsUCuJQsdaw53RJsdXG5ArPniutBCinDWdwIVkU3X6xXJdvrO41RBODAL3FP6f5mwo01
 7JJe61Ph73LTSTgL+8Mb+9YHNqKStnAXGZE69ymL7BdCOLzsqB0+ntimN+ybSifntoFz
 jIk4J14b8Ypu1EKO/FAUBOT4PE8NRlo+ctkeOTrTq8lmLazijv9NtMVuVRiMuVltnSsv
 x/7B1yD6mG4+o98h0FRJveOLp9g5fgYk4imecKqv6/HbsF8YfHKQtsC0HpBYRCVMJmOc 3A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c787c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 18:06:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 304HeOUi027030;
        Wed, 4 Jan 2023 18:06:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwcn6w31k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 18:06:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVg7akyykXGONInXjXdm93ONlu4ogzg+8wxlETm8n200Eg7hrj4Yuy0JVWTSC+oW9Fx1mGi6BxVqwt4kZFlRTxdwJ9C4h1Ky+cul4yXAYJ1L5NM6OUs7eTcs155kKcattdc2NNrpV9A8brdBTWwHc6KEZ3n5nLhoLmGN7yEJei5QjMT2lGwIupWHsQvs8QqImNu99DSz2Nlr5GAhqzsc82RJV+XZ27k0XW7A7jk924E5jAbWwzq4hkhTkZ8fFBEVfPogF2rdOH7mL+G6sy+y87dJXJE9k5nidXp8972f+0ghc2CwbBuvW+qz7+GkOGBN5U+qcRGJxPeYDtnx6ZzDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSsEfCHNYxA79Ekbd/qpN4PHkOgDNNIIAz5RdJOkBYI=;
 b=WjvIdFgsfWSEnZ1l5rMefxgMJNlxzNlKP2qWTf/OFowNDndzgsgWPl+jm9/Wh8fD+rclRfU3SKv/9pbB5nf+5/6sNx2U2XBoDgtdgLv4VpNKt01HpgY/WJCyGoV6o+xyuPfVDa0R1svgMhacEDKDJn4vbrmKBwZhjw3+GmHjYlyMH5aiW78N9p/hydfWYa1BKA4PENYVMFYvcs7SNmWfsgwTfO9gxmKsIMcYrZmHfuDsXVOvW5M0fI/7GMFGzRjv2oVd4zc0MqWM2ZFMhOeNnGNiyhlQDo9hGf/aEvqjyTBZecPxzQ3Rby0S/VA4m9WXObGtrR6uTmxvlmWelxs7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSsEfCHNYxA79Ekbd/qpN4PHkOgDNNIIAz5RdJOkBYI=;
 b=MkVmRRc9uDcrriAnt8Zo5wm+ak3OUkyhQ48wQCU045qyiDi5BfCXp7O58fNvMi4cnjLL6R4x7lmbMfqsomS66wEcS56M8+qTVxiGbo3QiIBw5ehuL6emOpOk+okf48wuOJ+ODabNLX8XXiUu3r4A2Z2cdLGANBrBiVqMhfHx0Yg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5575.namprd10.prod.outlook.com (2603:10b6:806:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 18:06:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 18:06:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@kernel.org>
CC:     Rick Macklem <rick.macklem@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RFC:Doing a NFSv4.1/4.2 Kerberized mount without a machine
 credential
Thread-Topic: RFC:Doing a NFSv4.1/4.2 Kerberized mount without a machine
 credential
Thread-Index: AQHZH9vamVQSE8pdpU+4JSLI/7+74a6NhDYAgAAR0QCAABflgIAAoyIAgAAybACAAAtjgA==
Date:   Wed, 4 Jan 2023 18:06:40 +0000
Message-ID: <15C694E4-925B-47E6-A054-644A0A142F88@oracle.com>
References: <CAM5tNy6nfvuqM30DwUVjTFHfewL8tSEQcyEJsSBzyWMTvDkEQw@mail.gmail.com>
 <e9fea39e926486146505c385dca50c116deb22f9.camel@kernel.org>
 <CAM5tNy7GM-5m-O2GUBwXCY=psSN2LKiE4bPPFyK=ABhObMdFCg@mail.gmail.com>
 <6ed7866da1e57a46da0108e9581242cd7f1ef2ce.camel@kernel.org>
 <FBAF6EA3-D78E-4F62-ACDB-8582973B4A93@oracle.com>
 <52f00169bb54c082dbffbcbf999c8096cb16d25d.camel@kernel.org>
In-Reply-To: <52f00169bb54c082dbffbcbf999c8096cb16d25d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN4PR10MB5575:EE_
x-ms-office365-filtering-correlation-id: 7bc186ab-12a9-48aa-2d3c-08daee7e6e2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQMZ4RLbn9H+X5XcjWekILA+zyZue2S6sU7sHV1BCm5EJO+wdPfeZTyvZFpuw+sBmdV/FjXohyGhRUYTr0IzN17fU4todZlrBVmQxEKJyIORrYXCmSt+2H0ZWoz30x0Nby0i0uzLwTAMh9AjrK96hp1z/fyGg/8AKWHUcMuBreMcxoUqoNXRC/LXystOaA6NDQS8GKuQtzZq5fcVaVu9QGp+7ldWVUHhtKbaq+0JnkpLY4C5tKapiEpz4Jn/3hdhFuiaN67GZGr1tjoZaK4r7Hx2zJ4kqCSKk3/A6jFK3Oytvsb9yMY7MuxzZAxkaR6Zv7FJplC1LwfMykymVId3siF7OQi6pMqko1wZGizAKBtb42VfteTi2ERUYmR93GUeqqiSJkuiaUGBdYqJr04S0AYs3Uwako8wJ3W7/3TJZe+wg9n8wtz+JjW+31kJCaKHUy/9VO5zM98AmUtS4vlfy3bIwVYj3EyvSgSviXi1FcG+ZgXv7N9zEuzNvPbI8UjCQ1zdT/mRdmowTcvAvBZZu++0w2O1gtnPE5f9NfnqOKdoL5OUPtNiaO2noUlwI0i23J053iVlq+YQGuf5UpGOc7MPUugPhxSuAREfCDRwidlsMZ7LTU2PZJUEdAn5LpDxfUqluWXc+a2mECwpDeW4upgD0hfdgLBa6dE05LZOYAzVfMMK1oN1acU8SjOmEf+YYeVq3nbTFaOHrR3pIybAzv1iwOygg0Jc7d1tAvk1Yiw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199015)(38100700002)(36756003)(33656002)(2906002)(5660300002)(86362001)(41300700001)(8936002)(83380400001)(122000001)(6916009)(54906003)(66556008)(71200400001)(6486002)(76116006)(66899015)(38070700005)(66946007)(53546011)(4326008)(6506007)(66476007)(91956017)(478600001)(64756008)(66446008)(8676002)(2616005)(26005)(6512007)(186003)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JciiazT8gXWMRTkfWtfINdBZg3ke97VDNVT3W/uAQJ2DcAl1f+6RA8CpNs6H?=
 =?us-ascii?Q?yq01xANwQzwxbiPe7J6V/IPFONPCo8e9RKz/djkSFEVPFXBtd1qgO3X79GjJ?=
 =?us-ascii?Q?dtYsGzy80sGMj2PbeBhCvIWNY2EJaDmDiG8qoyaelZG5SzXvbArpW+ULF0LA?=
 =?us-ascii?Q?OvkoZNe4hrbse7+TddvWY9YG6Od6j9CaFl1cjZClO8lF1fb8sousI3CNelK8?=
 =?us-ascii?Q?qrXuDtZ7UouQhKTNkHPYLi9fJDzoO/GT7L9E4G53r/xwRSEprtoPwijlJazN?=
 =?us-ascii?Q?lBxM9yay28kQtdCkygiCGh36D690klCY9RBnSuwyrawT47AWaw2SU94YoYf2?=
 =?us-ascii?Q?OL5TbdU3noelsTMOO71ba/beEhCB/zscCxHxf58Ik+YHlkIpZS9qFZUPS0H3?=
 =?us-ascii?Q?U4R8umkceCdMkBBJaAuwNpUxle4Jin3fvy4HX59iA+PE5VGk+hOWT5V1i6Wt?=
 =?us-ascii?Q?7mq0eavIUnicUWkSQ856e1w4a0B6RSjRHIBUczEQgNdww/9sKg1WLouMD/+P?=
 =?us-ascii?Q?0MU7t+Z46JVQFUW6WuZNf5HAufEaJbMcv5VSKwFTBJIrWqV3zgaize5aJt7P?=
 =?us-ascii?Q?IFdfisMwNsEbABncCvmvGD5Zlj7MAjgZIbRcL23Vm8LjDfb5L1ZkMjc//YUw?=
 =?us-ascii?Q?OaiQqj6f0uYUIszwHP4AOV4PmuYLy4fZcoIXDs9VgkXjHr0t38DQ4j0K2p25?=
 =?us-ascii?Q?jQ3o3yYY2hl4L42zNYT3XDzeebvOzDjO4bE1/n4Y9/DtEScfzt8P4TzCmqkQ?=
 =?us-ascii?Q?yNMLa2AErCMw+s5H0Cvjlzjf2ZqC12fqj46L1PcKZVhY6SqKCEKvV4t6wXYb?=
 =?us-ascii?Q?D2iODKZdi+7+4789C2F6dTdYsPf0OZS9HHjbb0EF5bg7onl2ZgeH6LJuw7i6?=
 =?us-ascii?Q?YoV57eus53KQIdW24Ac/CCJxJt6JqJUOVNh7CyGaZ3uJJPjjSUEyVBckm7xP?=
 =?us-ascii?Q?ZwL77YkgakNC9CBlc55iwyNQfdhkeJvZvHdIfAZCXCOfYYyqhAEYu0Z2Jtry?=
 =?us-ascii?Q?/yeUt0oIjTA361CzW/LJ6zOEazmu/hf+Kfexo0ixhdCNe1zMqmQDiPAqxnJ/?=
 =?us-ascii?Q?EbtSzNBHrVobozzCeJxwxD4gVW105kuP0hb2PFMtri6D/SnmC+Lid0GlmOwn?=
 =?us-ascii?Q?Xvj6dE1UyxZUiTKdEZWe81CTdVTd1xqRj5fzxR4MB3dfCQ1btYbtM7MQeFBb?=
 =?us-ascii?Q?HxkP0JqZW2bKh8cGoQFdMCaoal90DQ+vwlixezWGy/E7PjNFwnt+6zFOo5Ft?=
 =?us-ascii?Q?g1iAvxIPzdZnVA5nS5CfLVGn07ri/FUA0U3DEFlObmmdzgBKVYB4Cg5u70QY?=
 =?us-ascii?Q?X0ZpE39n0ioE2keasmC6rFa8Ky/s9kkoU+GCxL5inXdgXowZ4/FlMDzTSGXl?=
 =?us-ascii?Q?4NvSjq0HidR+LLIIKqk+qWPgGpsi7aw7cdf+5o4IGdbxJnmzEyJV9JyZLwQ4?=
 =?us-ascii?Q?TKyGFyMTvE1CT5ziJ7LCl2MZpy1tyRGfD6JHO1xyNfLwDcI+6YJxyZ8UFPvg?=
 =?us-ascii?Q?iYKeoH8tm+UIXps6PpkZQD6ufd1zMoe1AWhmefNUEzXdDsK8tufNkrpTFlht?=
 =?us-ascii?Q?awhOvIC+UTe4lpWcdzXj+RTwlxJ/rk+HAz9s5y7aXaQuSnjFdWwVhIlhb5d/?=
 =?us-ascii?Q?zA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D74CAAAD2073D46A0C14F827450F317@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Uc1lL8Ta3hzBqsRPsNP1lu3MwQnbyXzekvrqP/5k9BtPZhbVvHZI4vu5p4WK1Z98+TLbixkyqFzC7fWjtrKKHsvLMmVcAXAhCWvf+ZTL3y0J9B4Ot4B3Dw4cvoWlSuacGF42s1C2xLgyq0oh0mQMFHjBTieAXw1svpjX7OuEktR3IikCjXk5rTILv/EHsUAzYYHy9G4/HfaF+fGmlDWy0TpWu7h1rxfszG544ATMpXv1Xixbd1q9uA7esr2QIBx1TazkAJlST+Od5eHbQyHu3odNUb0WRE6MoyU1aBGAx4gLK1llnmd+wAN7sH68vsayo86AF13kPfq949/aH7gip5b+GOLSvFJnUDqUM2ULGObYppx7CqunDRkDGZmpmsTce01/xrrnX7NE8Qt9MtisI5aK5Yy6BAWW/2O2n3U+XNEy70IuwEv4X6r+FTHFFXqdes750lSck67uVzKa18FNpgu+bozVTlxpgPp5ifQ/iTinhPRKT7K6zvPh85OQ3s4yC9YbJXQr75ICphqxwZyNeDtUbrYqKMxv9JRrIwEO3PqGqH+gerJBPLXuobbDjzmF+V5VIBzoN0Rt1oqPY9oS50kp2kqJZAGnUUMZLFPtjAWCScDY/hyw5+BFAMwSUmeEMgXrFBUIoLUZn7VKWy/5stG39FqyqP3Iu+SjXBXqgbilzMdklsDck9VUtO/iRZTfkt1zV6RvilLlYIdGExF88dHsZhr+qEPsBPmDJNgMRMTYcGnOIKqHZme/VsGPkJJ2roYMdz2+fG0tXIWsggUqjM7jTMcYf5exwxyxr9ClyFg+JFbvky9MsRw3M2WCtnk0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc186ab-12a9-48aa-2d3c-08daee7e6e2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 18:06:40.7425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bb8JurtUU+K0i0q8vOUmNyN4v8VGLaqGf5Fgrc7yN/c9BfBfp4ZceNoSkbKK7XFTSkMi0VMmrXfJCiLacgbdBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040151
X-Proofpoint-GUID: PW6AD_FDYpuASKQSHmvJV433CUKqpRXY
X-Proofpoint-ORIG-GUID: PW6AD_FDYpuASKQSHmvJV433CUKqpRXY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 4, 2023, at 12:25 PM, Trond Myklebust <trondmy@kernel.org> wrote:
>=20
> On Wed, 2023-01-04 at 14:25 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Jan 3, 2023, at 11:41 PM, Trond Myklebust <trondmy@kernel.org>
>>> wrote:
>>>=20
>>> I've been thinking about how to use a public key infrastructure to
>>> provide stronger authentication of multiple individual users' RPC
>>> calls
>>> and multiplexing them across a shared TLS connection.
>>>=20
>>> Since the client trusts the server through the TLS connection
>>> authentication mechanism, and you have privacy guaranteed by that
>>> TLS
>>> connection, then  really all you want to do is for each RPC call
>>> from
>>> the client to be able to prove that the caller has a specific valid
>>> identity in the PKI chain of trust.
>>>=20
>>> So how about just defining a simple credential (AUTH_X509 ?)
>>> containing
>>> a timestamp, and a distinguished name, and have it be signed using
>>> the
>>> (trusted) private key of the user? Use the timestamp as the basis
>>> for a
>>> TTL for the credential so that the client+server don't have to keep
>>> signing a new cred for each and every RPC call for that user, and
>>> allow
>>> the client to reuse the cred for a while as a shared secret, once
>>> the
>>> signature has been verified by the server.
>>=20
>> A laptop typically has a single user. The flexibility of identity
>> multiplexing isn't necessary in this particular scenario.
>>=20
>=20
> Yeah, I don't particularly care about laptop use cases. Most
> enterprises set up VPNs for dealing with them because users typically
> need access to more services than just a NFS server.

The trend I've seen is that enterprises are moving their important
services out of from behind VPNs and into the cloud. Each such
service is responsible for providing appropriate levels of
authentication and confidentiality via a single-sign on service
and an in-transit encryption capability.


> I am interested in the general problem of authenticating RPC users
> using certificates, since that is becoming more common due to the rise
> of S3 object storage and cloud services. While AD and krb5+LDAP can be
> extended into those environments too, there are plenty who choose not
> to, because PKI is generally sufficient, and can be more flexible.

We had SPKM. Would that not work?

--
Chuck Lever



