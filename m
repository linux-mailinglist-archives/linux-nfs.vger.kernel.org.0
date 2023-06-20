Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E6173725D
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jun 2023 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjFTRKy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Jun 2023 13:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjFTRKx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Jun 2023 13:10:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F9510D0
        for <linux-nfs@vger.kernel.org>; Tue, 20 Jun 2023 10:10:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KGDvuJ031236;
        Tue, 20 Jun 2023 17:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=c75J6qn6qv9OUkWL66O7Weauc1xxz54t7bV1CtuD9PQ=;
 b=NhfWGUvn9cQ0vgLGrhkRvHK3agPhte0G0FUsawUEV1Q0gXv6uDi+uktfuLSB29PH/bqm
 UTlrDObHg8lUT6W59Q5P0qMqJVS6iIWWzUqkWS3z/yaM3gLPoow7TsMSQgwo6d8UnFrE
 02SAmPdk/q5wXxNVifXPV51AFgin+frVLn/Ne3kzot2VXUlverenSuMJd/WjKCVuvjuL
 kLGtXdKrCyIuMPpvAdUsClwU7Gmn76R948PgB8MOsnONMfnC2hq9OhmlNJJKLnw/GJ2x
 k9BSWbikOQ3Zv19rwqSKysnlt7YMOIYaEy0AnYlWd0yUHEVb1KNmkIMccSVnn32q1fV7 sg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93e1dar4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 17:10:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KGUOq0008538;
        Tue, 20 Jun 2023 17:10:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r93955r8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 17:10:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya/PSG5Iq9NyX/HMmyGsQiDOrlGxgHcaVY3ZIx3rHnpwJHxT7yieM60K98Ybb1hTL9bwMB7ckhMSFCBmODoprBrhFYm6gv0vVgCwpW8+Jcfh31fes9qMIgmO+Nuj67xwU6W7iuJI2g0rjZJxKakYlT9Lqc9k4+elnNmZ1eh0Mf8ZLwFDN3pUukYfgBgm6TxmdVynj/O5LyINPyQEGNq/A83X5cFdbzvvHsaxi2t/nnZeTFfdnHFixDVUDIDgzut83lXTWmWFZUsAAHOTmU1yNIkGz2wvopaKH5neXOEzbtEgmBnV+P23oEJNIV/8URNkoudq5geNiqr1nPvQc0Fq2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c75J6qn6qv9OUkWL66O7Weauc1xxz54t7bV1CtuD9PQ=;
 b=CiTjvekFRKHDDbK8WD4qx2dHI7QUriXV+3+l1O+MfxOf0D+E4xeeAB9FNzHSoX9kIlSxkDtktcGy772G9cjn3bcWZPIyu3iq5r5MP7dyIZN+AIzHTzOKulAQzPCZu15vOTZgBFQ0BHQC4Y+xugU/gSRHSMZVBfY7Qm4tsOsS+LQBKRsjwjsuPfoSlDzF6GxkgjFcQuzB4oz5NtTNdBdmGHqV9INjtwe8PgBbOvMyJu2YU5lTiQFkEcdW4PpyUaasc9Gf6YKfB8BP6roi+bjvKNm1kg7wndDCfuGhCqff7miGmkPEwqTAYof2ZcQeWQdm3VP0XNrxjFYdwS8SobBXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c75J6qn6qv9OUkWL66O7Weauc1xxz54t7bV1CtuD9PQ=;
 b=E3A8/UVzs3sOkKsmUATpjHVh4YLXB00AFn9J7jVaq10cHt+4Zo719zrrLoKCzgOz1XyowzrNkXfMGHTkZxZCw8GnNvArSundtqgMKp8N+g6Oe0BM/Wh+rVT6rRxTcwcMThiKLZJmneH6Ft+u6OrTt0qwShkrbeXnmoVwa9ClCEI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4817.namprd10.prod.outlook.com (2603:10b6:208:321::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 17:10:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 17:10:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.0 Linux client fails to return delegation
Thread-Topic: NFSv4.0 Linux client fails to return delegation
Thread-Index: AQHZos/yj80TeHCL8EaHc5sJIN1lPa+SgHAAgAFRTACAABzmAA==
Date:   Tue, 20 Jun 2023 17:10:46 +0000
Message-ID: <9B7E8AD9-C418-4E22-8EEE-B101F1D2F662@oracle.com>
References: <f9651599-846e-3331-9353-8a8264de1a27@oracle.com>
 <d5efe21b5f6a4bc7edd0f8ed441f63aa76b7e41a.camel@hammerspace.com>
 <5a43e57a-eb00-6f76-87a8-1a80c584b9f8@oracle.com>
In-Reply-To: <5a43e57a-eb00-6f76-87a8-1a80c584b9f8@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4817:EE_
x-ms-office365-filtering-correlation-id: 39ff9476-91d5-44b4-d99e-08db71b14a05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hLsR1cOOGPrjTfNZSMGlMDfsBteoigUaf7SbrFeKt1bm1qCHGP3jLPPo6bI1M/EThaV4Y+SNyOxHquTSWP3ukP+agO8IaUODoldYjqtiB1OQC614u5XqPv176wIibVxMgeEnMMCO7H/rnD0cFd3Sg7+FCIZ6RRSNN7kAw0eBJtfz8xQk+t6Hskdt7ld7TU1Oo49fLe5hSF8y8f1rsFgXM8RcqDLqT+KVVv1iYYxreQMFJ4BnXNW5WjtDRT6DmoDUBKWUwU0kP3I3aPOam9OZd8dLGcyB8WFbIP5UgLpxcj5lmgrC59GzeGxBojAn9dOiTHmyVnZxid1iOte+H+5sudYBt+4RdMTBj5Ady+8L5B1IVAefy81wgajNkegTjAK/jqlJuGjRMsVlpYZNWZQMUw9WsLrECmd7tZm5W+NVuiwAhBkSU+PipicpYDm7gLQJtBj345p/QaKYNhuQclce/2E+dY0CYosxRxhfQYJLazM61+AflSdb0huuWO6GBAH/delH71No1gyq3XqQlKWUuc3jnFSQrNCMFOyYVU3fMJxhNVhm3fcqUmNterIn3Wqiu0hel2Tl8dsSqRy/ZQdjwQaKNjlbgAVXk4nBY10ZxQ2NsrNPIiLd256TpwvwUBHqMFc78qO4zFUTExjOmWVl1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(53546011)(6486002)(478600001)(71200400001)(83380400001)(54906003)(37006003)(2616005)(186003)(6512007)(26005)(6506007)(2906002)(6862004)(5660300002)(33656002)(36756003)(38100700002)(122000001)(316002)(76116006)(91956017)(6636002)(66946007)(4326008)(8936002)(8676002)(41300700001)(86362001)(66476007)(38070700005)(66556008)(66446008)(64756008)(66899021)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mqjRw/g+jH6Zha3DCj1m/b3/5Ns9EM5Bxd1vhxS+88fvU5yBgiiFMdNLS28C?=
 =?us-ascii?Q?hAnhkVP1MTCHopg9G1qe1eNItCLZPoUtlOcAZm4jDF4lqc9rF7YmZBSbpr5b?=
 =?us-ascii?Q?tfcwHTkFMccZzf9Q5hESEqMVggl+QVFLqVUQuKREBSeLdlKbNPnGiazov9D6?=
 =?us-ascii?Q?jIHrHDf+/9871Tig1zl+3BXm/sv7R+CuQI2iRpdeK3e69i3d7wooDpcuPq8G?=
 =?us-ascii?Q?M5AHrM+rUDv1JRE4Ihz2gO3NRwX075+0rYP8fb7vrV9VGRB2zU9uigEpOaQ6?=
 =?us-ascii?Q?sibNeoWu+/qsYKjTvu30Hk7orUcJd/MD4sKetAoR6dnzRG4C0bwHj8MjyR+n?=
 =?us-ascii?Q?+l+CNutxvERfFqVh2fRjyksaqiOEBtSq8MJTXvhxwT5Cs/y6as4kyInQol+s?=
 =?us-ascii?Q?EF1LDuEyzuCm+n3po/l1S39U+kvTHmoFTKrqWt1sC55UeCPxn1SeyLlzobdS?=
 =?us-ascii?Q?fKM0b3cRxpeCjmggGWSi4xs3UOLIemKe9Kh21LrvWbVqXxvICq1+Z2KvVrl0?=
 =?us-ascii?Q?Fy6Nc4KduosSYniOczVFHt6W28YmY1VRRjcs4tNnbAaKXWTtrsVj6U4xatVj?=
 =?us-ascii?Q?ZiYfo3McuG2iaxkDqDKc+GbE+4u2T8aA/xNjqfKNBzPv2N2iSBvOoND4o0in?=
 =?us-ascii?Q?JDSkN+qGc+VWlUfH3wc0sP3X0i4p6lHNW2ffsKgHppPrwGXZB3MJh2VCAgXK?=
 =?us-ascii?Q?iOMabzPRZqd+PRse/LN1sXFnwPVlQl44KYkwAkWVik0imI+u8RX9IzPkfN4p?=
 =?us-ascii?Q?g3v7R5UOSjZAtfbgYZ6bQsVUdLknMSnvl2Ji7+lJsZcSx5BjbKAZD2Skq/7G?=
 =?us-ascii?Q?713qkp6S8EDlFAAg9OqG1rxHqZCkWhdPGnm1OSrAPmI8Tx/3xJQZRxfM/Ok5?=
 =?us-ascii?Q?xbeGlRrYwZA3Qjyu7hIE5WCw09WObKTnp2oP1C3eviWjE/HlRM59nI1ig2TR?=
 =?us-ascii?Q?M6hSmskfAyJAnhyUOLjK5BTMEZM9Ak3MXOlGRqKspv3Q9M+AuTTcgeQ/xxYA?=
 =?us-ascii?Q?y/ALn++zniFNp2AyWXS0oA5oBZl7a/kAtcsxIe67h3kWhi4xTQbSMRevCA15?=
 =?us-ascii?Q?OpZ53y8EKC/yx+Hmku7OZ09Hj6z4CckPMH1mMSRrRObG5f1Qxg2711Z83wLG?=
 =?us-ascii?Q?phzgl+GRF4XsL3PYa8sVn2nzPOWWVtpRg+vuAFoLFqixVanUHL+ZZbekvMGP?=
 =?us-ascii?Q?6doOHa3q+m/AhMqPSVDVFAX1Sn4eVQ2ogpJRJxGImms4hz+cYHsPMExYKAzo?=
 =?us-ascii?Q?m0tpJv0eIFjfmEyR/vMAoWVfYbNzavruTPyqIM0DSVKKcwJ7bdlN2t6gh2GS?=
 =?us-ascii?Q?ZiR2VmH6CxI+jbW4qIlygTQZvQ0+kcow6O8mhZFLda0ilQGO4c5ovmcv8V8Q?=
 =?us-ascii?Q?k+Ic1nA+R8V3TbYGtNmAr/ba0YdvOTw+AkGN7Ij6Z8zqm4GWflZgap2vjVoD?=
 =?us-ascii?Q?HBn2nfiD4kMaRM57sE+gt9AEhHfpmRJXt/9uWmMtABtuUk+wRk+WCPxFGnMd?=
 =?us-ascii?Q?on21M/+FZtDHPJrCvo7M/uQ4bzginWBQW/XFGbc/nhxdVAGy9qAIDITxfsVv?=
 =?us-ascii?Q?aqR/5yJxCgDojE8DFj6OJlwvu8nYTY8hpJLpGDlBDuBBYc4UFnm2HC8ILKA3?=
 =?us-ascii?Q?Ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B8F251CD34FA4F42821867EB2B04DB18@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FWXE6Xh0Jir9pE+hn4t9Fn9wWdSSQCYluWixtigTYnFxqDCbdJ8tx7aOGv6uRqp4VEGGlMUppSOWGynKd1bQVO43QaNtWY7DnnWPSpyS7M2RTEM2nOJMLOjgxiiLSMC4TmeAMhaJI3rGVS8HNWz9NsQwktaPZ6bleutJ7RukhGkU5+0hfNuvoySxomsu9f9kLcF6CciiEiCc8WGS6nhh05/d/+92S63eCq+wasH+TQu/biiCEnGKF6h42TcT/Hhch3rGCdyxzrFvaRnvSaBITYkYqbvqsTHaW9G8emHMVjf/fiJWzfrj7iZw8soPJFHbp2rdqSF1+YuH+vO9XHYYUepSen5OeXut8r/zw268ugW8lGL13KRwAHetb27SHB0ndjHG3IY00EOSqqmrDcny39CNiQ/OhbAaLE1nDJyFW3S0i0gbKrJ0b1ZQJeUBfMVcCwXvoGxgYuUxzZctxPZvjA4dsHwFGOv2AiqgjI3nIVp+lZYual9mIE8UOPSTD8DUFmtoNMvG+bmwXwqdtcDNzguPa4ICiKy+0PRgaJUJbcyzrHdFIR7J2udqYRUS6my5zDAOprtavgMdSwbrto+LAFHsRT1dwDkwsVuEq6UxLeo5PZ2yHtSVMGpTMSgmFEojHcAR23goyxaKmn0iZqYkWzC2E3WNsTGy6h4YsTAGur8uCoD3obrEmMNOjrOVIHRkPquXdDnhD7TRe0isLQrQQMZulYVRjMgjQcsnXybhhROwQ3FbgGZpN7fI68XSO/UAKgchWaTuOk/3KlOUKop1SP/tBF2kw/qpD5Gt24LcqRl0BgEtAFvKDjhZ/2befsP8
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ff9476-91d5-44b4-d99e-08db71b14a05
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 17:10:46.8088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shWgFUGws17Z7H+4mK28eZKrfpgzBhvM6e1aUzTd/v2jxIAiGS0SAhlMKn2OyV7SzU6h3N159xFM1yXgol1Nng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200155
X-Proofpoint-GUID: FIkI6ZFFcg1LYt03rfc2lKNOpBYF5-kf
X-Proofpoint-ORIG-GUID: FIkI6ZFFcg1LYt03rfc2lKNOpBYF5-kf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jun 20, 2023, at 11:27 AM, dai.ngo@oracle.com wrote:
>=20
> On 6/19/23 12:19 PM, Trond Myklebust wrote:
>> Hi Dai,
>>=20
>> On Mon, 2023-06-19 at 10:02 -0700, dai.ngo@oracle.com wrote:
>>> Hi Trond,
>>>=20
>>> I'm testing the NFS server with write delegation support and the
>>> Linux client
>>> using NFSv4.0 and run into a situation that needs your advise.
>>>=20
>>> In this scenario, the NFS server grants the write delegation to the
>>> client.
>>> Later when the client returns delegation it sends the compound PUTFH,
>>> GETATTR
>>> and DELERETURN.
>>>=20
>>> When the NFS server services the GETATTR, it detects that there is a
>>> write
>>> delegation on this file but it can not detect that this GETATTR
>>> request was
>>> sent from the same client that owns the write delegation (due to the
>>> nature
>>> of NFSv4.0 compound). As the result, the server sends CB_RECALL to
>>> recall
>>> the delegation and replies NFS4ERR_DELAY to the GETATTR request.
>>>=20
>>> When the client receives the NFS4ERR_DELAY it retries with the same
>>> compound
>>> PUTFH, GETATTR, DELERETURN and server again replies the
>>> NFS4ERR_DELAY. This
>>> process repeats until the recall times out and the delegation is
>>> revoked by
>>> the server.
>>>=20
>>> I noticed that the current order of GETATTR and DELEGRETURN was done
>>> by
>>> commit e144cbcc251f. Then later on, commit 8ac2b42238f5 was added to
>>> drop
>>> the GETATTR if the request was rejected with EACCES.
>>>=20
>>> Do you have any advise on where, on server or client, this issue
>>> should
>>> be addressed?
>> This wants to be addressed in the server. The client has a very good
>> reason for wanting to retrieve the attributes before returning the
>> delegation here: it needs to update the change attribute while it is
>> still holding the delegation in order to ensure close-to-open cache
>> consistency.
>>=20
>> Since you do have a stateid in the DELEGRETURN, it should be possible
>> to determine that this is indeed the client that holds the delegation.
>=20
> Thank you Trond. I'll wait for Chuck to decide what to do next.

I don't have a technical objection to Trond's proposal. But until
the WG documents the interoperability requirements, I don't believe
it's something NFSD can sensibly support.

So, until the WG weighs in, NFSD won't offer write delegations to
NFSv4.0 clients. Let's be sure to document why in code comments.


--
Chuck Lever


