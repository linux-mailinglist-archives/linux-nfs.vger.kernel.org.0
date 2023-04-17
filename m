Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1076E540B
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Apr 2023 23:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjDQVmM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Apr 2023 17:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjDQVmG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Apr 2023 17:42:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF71361AD
        for <linux-nfs@vger.kernel.org>; Mon, 17 Apr 2023 14:41:45 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLTWSY015763;
        Mon, 17 Apr 2023 21:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tbaXr0+lZJ0zI1t4md2lyvv4ze0HerGCb1jbY+PxFew=;
 b=yNNjfuGL3N/eXnt4pYR3WJJCi2sN58IexpazMbQwJcl3fTCNot1oXPWdA+WdY9O6Edsb
 hDWkHfWZBa+hJ00pupYdMwSNWY8CoAUdWDk7EmL4GJqaCSefceZUQ+4z+cBFlz8gEHIb
 Ojpx+liuA2HHu2AZ6Q/uUEtbG7KteOUcnMwn0O+Er7dwYHSNoThLuqoXkM3tp77OroSA
 KhTj99kuiMN0kYC81OFpBe//UOBrZ5oFtvswVoIuehzFghr+YvuNY6P7fV6Dn634q03c
 TfVUNzcWQ04L3ktoOAYcpDapbTjcwC6VoVt/0ejVOFUVgmLn/HOuFeTWnALy5HtSdWm5 Qg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjuc49jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 21:41:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLX4hD030793;
        Mon, 17 Apr 2023 21:41:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc4ec57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 21:41:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEkq6h0uQOrC86oKBHT+XcbxgjowLTTGEQBe1VGa+Q1atmzKX3e0zTrRieOJNyPUaxMuiHgx49mDDkdknTu2uRKge3Olw6r5FRiXIMVJNolYjd6OpnumALfJHyfE+P5aZDt9eS42dkZwMUq6jmk8en5o7kKwPIXqQQy1dHV9L7o0xLTMQ6MoE9tDv5k2m145h4JZiCSWbsr8EeAmizUQ1MGBGS4yrfa8mJcu2WtaSunoo0xbUjQTzScEms1scdwAuEq/9NHQyH3g/iKqIBx+wnRIxSBQFfOqZgGvJdYAkLZO+1jOYUUM4oKSPZdmfF1pUzelY1c+qTKOCzWx4Kn1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbaXr0+lZJ0zI1t4md2lyvv4ze0HerGCb1jbY+PxFew=;
 b=j/TaYzTt5bUlw5cdHsV8SMeCO7qG1ke/0CS/mQUpeJIB/EngdCK+z7MJK+pbh4Y65qvznHFYWYATgLGrqGfoDH3YBCLN33wLVej++wZtkIoqX146o6g/McIE7FvNeYm0g/9sWhXA3qJvr5/i6fTLm7MpEHLL98qUkFJvySkIimYUaKQ0TQ+n1LLFVg3/SaM+Ok9yb4uYwyTb7mZSEmgtQrufJe/4n9k6hhhI7zh7uXUt1e7yiHgx8M22vNTseGljb0XMMfcJ+LE6o7q6ba7M46yXQLG1yl7kQV9an33J3L8rbk2aGk5IH/vUNYUIp4tRqSqhx6y/FOlqe2f2XkRoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbaXr0+lZJ0zI1t4md2lyvv4ze0HerGCb1jbY+PxFew=;
 b=QT0ni2ThyffFHZpbdDDFC+fsQTUBQUmqSOpcKx0InqoD7oqp/+T+L7mq29POX/f+XUIxGdBonkLmCTm341+Cz2asIp7TZAoWAYpk0B50xtMAjnk7NDIymx1kWO/HuUv/ruFr/lNUevh6fbp6JovRQFO47ihdFSm9eeEtBaNbc/Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 21:41:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 21:41:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Thread-Topic: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Thread-Index: AQHZacp2wdCHl9MJskyADf2q/cMSEa8wCLYAgAAObIA=
Date:   Mon, 17 Apr 2023 21:41:36 +0000
Message-ID: <C7FE1DB9-576A-4463-81BF-E7B1EC266E4F@oracle.com>
References: <1680924600-11171-1-git-send-email-dai.ngo@oracle.com>
 <ed95d6e3da7b2a27a27837f19ca39980037eb28d.camel@hammerspace.com>
In-Reply-To: <ed95d6e3da7b2a27a27837f19ca39980037eb28d.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB5749:EE_
x-ms-office365-filtering-correlation-id: de7a571c-847c-47ec-5ba8-08db3f8c8507
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LEvvf5XNUAY9LrlawOs4JDzgJCAJgJVzbWRDZomdD8O7eRqxtc7aq5hScFAH7+NnooT+bhqeQcxjHy8CnGX99Chu1vjr5B1UBIh5Zx/JTGJsrKO1lEiTxS5iXjv/nAfPQWoGNb6Rox2YHzdrmGQYNYyiEU/flFhY7trK/N4+1BUq0vOMdU/y/eVI/QNX0CgASJFjSuRbAQG5SoXBWwXORz0xNj5Rh0kDH1SsH32qs2oYPycqT1SARmK66XNHxizxQQZJD/tXZ5N+Laj5KNrc9FfOZanioQB0slEu0hH0ZX1z6D+MLCv0nSS3+nGIXnmraId8tjsBN0PY0azGiDaiskTxbUFsPgdCK7f5WU8JhZKKkz0X6LReYPBIzP90VwLPyHPmMe3dhcnNnLP79agbp2aQvdaWqSYhQk8yaA3qcbkGcfIFq/dw1lJ+/n3LITS95ozVJX6Kq2iXJYk7g10//UpbVCqlhj2i2NyN+tc5ccU1sBVIgoCb2b803OWuIdO82YxUtBawANLvFAuNrZUdchjNeTc4OwN3/QWChVf9xrYcmK5jFpMKigQ/DjjFmbmkRylE+w8CfvkP4kP1WG6Mqdp+1jjtDPG2mfOolkYFSoTWOr3K5j3crKjhL3x76hlg1AKR264YBZXKT3/bOSf1fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(5660300002)(71200400001)(6486002)(33656002)(76116006)(6916009)(66556008)(66476007)(2906002)(4326008)(66946007)(36756003)(64756008)(66446008)(91956017)(86362001)(8936002)(38070700005)(122000001)(41300700001)(38100700002)(478600001)(316002)(8676002)(54906003)(6512007)(26005)(6506007)(53546011)(2616005)(186003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HH5tWyho5U8gpBxZ1Dx44eumpnSUY5cXGvbM4nW6m3z3kRtjkrKX+Ame6vC5?=
 =?us-ascii?Q?CFXtwpjtYCTWZ7+GvJkCLG7Hu3tW0KCUg1fDG0BwpsjUhCVVV4TZcDHZliUx?=
 =?us-ascii?Q?KNo1GvwoDeTAzZwuu5yz7pnXf039JPpPaPVN4EQ96E1h9vu1MXCH3XzkkgG3?=
 =?us-ascii?Q?Im0WjErte3UmAbUtCT0kFWIt0MV6dfokKV4VCTT31gL+t9YtwMFUbS5cNtcQ?=
 =?us-ascii?Q?JB4ssBhCa51bwEPH3YIwQoO6smxvQwZN6zL1j21zfidrGUJaXTJ6hrpMBDJQ?=
 =?us-ascii?Q?O47K3MbRQFLWu2p8ggjrKRA+Fp6lPSVNwCyRzi/rIZrcGHqlA/bp+R4c08pc?=
 =?us-ascii?Q?aO0Q9GPIM5ZpCxuPnbvv5wOfrnM51KFdI/bShowthzRSoshvGb54WYKW0BFV?=
 =?us-ascii?Q?GTRqNYwPtIBs5gKcT2A5hCFQNZFnT0rUxAR0jXRt1I2jHSzBXiOPH66+QGk7?=
 =?us-ascii?Q?Bx81mwTcbWw1jexJ27mIuK2hRmLz7Ao1bORXWzNi1zsbpx3uYdrcTeSu9Shl?=
 =?us-ascii?Q?HE38S7HizA9Vb+WPMBYud2TiEYbzy3tlWElraGo5n9Y+QgUWKLYDfo+eA7Fv?=
 =?us-ascii?Q?tV+ZGyDQKsn+hyxIvxHqhIajtrWkoiGN0g3g7GFnvFLJybiyH7og6LDwnrJW?=
 =?us-ascii?Q?l7sSPluCf/tOTO9PgMf8CVXgel7NNM836Sfk50ejoK1QV2hj1xvlH5C6BVuf?=
 =?us-ascii?Q?Yyi4VxDTIvSJR/w6X9L6ppJ7fhhTni/i6xCuJIwBGrrRsMI1ewFVU8Qls1bb?=
 =?us-ascii?Q?XGhKs3Rz6P4IW3UmY7sZU/9cO+a+DCRtd7vCV1i/gDpJ9glRKJqhS2CDs+J7?=
 =?us-ascii?Q?28MoaH7dfyAswMxMQiKt3rIX+qbXDes6BpVtDio2inOeccuQST3MBnLZXELu?=
 =?us-ascii?Q?vug99JMpIux9tTpCKG1gfHg4ZVzhxNH5ZjArNHRaG/00+Emy8n67IXYWzKTP?=
 =?us-ascii?Q?fiFx5sN3f6d7Ma95/sHigj3oMFsx4NqkTY9Ks5xoV39qfFwY7X9NPtRsEu1e?=
 =?us-ascii?Q?CXhcWvtVTnpEwDYuiZWK6vCt3NnDcL2pQXOJGciqwcNiJu0qQ2f6lOxqnSOb?=
 =?us-ascii?Q?9vCEDVvdulhsGOqtiDbFRhm4MmzKCq7Ssa+A6CIctOzCdaaoKPbiQIeonPaR?=
 =?us-ascii?Q?q10qs9KAxNSS3KVuK0wS2JOD63lBukMdvfpEx1tfMUcJX8KMp4WNTIdzJGad?=
 =?us-ascii?Q?hY5WybnEFVPSqYu//8ihHVFjck4k2+eCL4MWBmfC/YqmWFwATrMk+QBqCUD2?=
 =?us-ascii?Q?icgEx8ivnFpN3twWLoQBq9Fy4UByVi7/gs7lk81Z1t0spefCpIE0ehO/OPK+?=
 =?us-ascii?Q?CYMiSysD1+tTfHbbx2JreHpA/bGz1MS6+d9g2ERmonwPOe59PVCh3ZmU4y6x?=
 =?us-ascii?Q?eyD2QByt80MbeDXh77RQewxuinZae0ELFzfFlXWGWJAgNovJFvUlUYCOZ7w2?=
 =?us-ascii?Q?HicrtFe67hq44obhxep5Va/ZedcwQvU2ekSGl4wYNK6PiolinEDAqmG+PRAm?=
 =?us-ascii?Q?espvZ2W+4lwDl5CtChiECXid1fClJca2FblzpctNg9obyfm60WLO5LoExlAp?=
 =?us-ascii?Q?qJVDFj/lDOzGoZdzvINrPU1jPax+WCumk155pf5WeprQf/AKItMTfcNpC9bI?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28CB7A07CABFF44D9D02E87FCD2BFEF8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9mmYAwolNc6m9Y+P7h5XzTPoaeUYEUx43MLbzeRUPp5i13aBXBQJDfrId9t6RP+KZEeQ0EOJ1T112szoStaQTk/UW+C8FKG6JD7V6GbHah+BNARIWiU94Xb4tYU62AsJrB13zLNFik5TMhhlgKBeXJy9S/Ca4KXjWPCyVZySvL+tx3SU2W771LyNl+icNtJSDoH+cbMCTsf0hAsGK4uB+ZFxCeqctuzSLLPquklIETdN+OdIKpdo11W13/ADCmEnV7axnB3Jp3JFEbKdj+AcGw9Uqu/n8Fh4nAEK4E7jVcONpcbiKgn8JTELmUsy1M6lAFM+xDPb85kN0BuLEo+GsvAo7diH1lZ70KnBWGmlAagFYmuP6aKJiYIjLC5NmuWMs2a/Ok+84km4UX28cbm9ZD1SApRGTzvHwRxK5B8paoxnyI2jcWauPU4Ubt3Y4qEnqSK3x/J7Uo2syR4bDBMO6aFbGxOwq7U9OxkjxWrIqVjXkP9wAbmJfaRLwODTqUIZPqB5XMs3NmfO+4wR0p0eDfAjfCTOaG2VBHeGB08hgKZlYHZH71JHyCifgY0qTDdau+nBzQkdixWsnDzK12dR497gbHUqiYddMNdtWu3XnVQazOnpg3cF2eSAg5MUs9oqIgHOitk1MfikiTS2FSsCi8t6RZ1je9E36JjStRZEUFI4ZxNeV3b+Tt5GZxLvUGZHR0AiI13N6bVLfeeL0jedyp6wlATULAqXkmWIEe96EkxsV3OzvwugXsA91/er6ffdBLviOJyJ5AbKjAtPUVXsk8aktbbGnANROa9tYptFe5f8ogEsqndIQjgioHGNQCoYrlIH7+wYidQLm8lgrL9mDw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7a571c-847c-47ec-5ba8-08db3f8c8507
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 21:41:36.2801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhUfbT8SvSzq4GhEH5mEYZsCaNIwEqkwGFasGRvZlsdKD0eaezdUVMBHt3eEJaUAnjiK3hol92ZnoSgEZA0TKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5749
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170191
X-Proofpoint-GUID: 7Dt982b_bzHZt0y3XjVdVYwI83Y-zwRu
X-Proofpoint-ORIG-GUID: 7Dt982b_bzHZt0y3XjVdVYwI83Y-zwRu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 17, 2023, at 4:49 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Fri, 2023-04-07 at 20:30 -0700, Dai Ngo wrote:
>> Currently call_bind_status places a hard limit of 9 seconds for
>> retries
>> on EACCES error. This limit was done to prevent the RPC request from
>> being retried forever if the remote server has problem and never
>> comes
>> up
>>=20
>> However this 9 seconds timeout is too short, comparing to other RPC
>> timeouts which are generally in minutes. This causes intermittent
>> failure
>> with EIO on the client side when there are lots of NLM activity and
>> the
>> NFS server is restarted.
>>=20
>> Instead of removing the max timeout for retry and relying on the RPC
>> timeout mechanism to handle the retry, which can lead to the RPC
>> being
>> retried forever if the remote NLM service fails to come up. This
>> patch
>> simply increases the max timeout of call_bind_status from 9 to 90
>> seconds
>> which should allow enough time for NLM to register after a restart,
>> and
>> not retrying forever if there is real problem with the remote system.
>>=20
>> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock
>> requests")
>> Reported-by: Helen Chao <helen.chao@oracle.com>
>> Tested-by: Helen Chao <helen.chao@oracle.com>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>  include/linux/sunrpc/clnt.h  | 3 +++
>>  include/linux/sunrpc/sched.h | 4 ++--
>>  net/sunrpc/clnt.c            | 2 +-
>>  net/sunrpc/sched.c           | 3 ++-
>>  4 files changed, 8 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/include/linux/sunrpc/clnt.h
>> b/include/linux/sunrpc/clnt.h
>> index 770ef2cb5775..81afc5ea2665 100644
>> --- a/include/linux/sunrpc/clnt.h
>> +++ b/include/linux/sunrpc/clnt.h
>> @@ -162,6 +162,9 @@ struct rpc_add_xprt_test {
>>  #define RPC_CLNT_CREATE_REUSEPORT      (1UL << 11)
>>  #define RPC_CLNT_CREATE_CONNECTED      (1UL << 12)
>> =20
>> +#define        RPC_CLNT_REBIND_DELAY           3
>> +#define        RPC_CLNT_REBIND_MAX_TIMEOUT     90
>> +
>>  struct rpc_clnt *rpc_create(struct rpc_create_args *args);
>>  struct rpc_clnt        *rpc_bind_new_program(struct rpc_clnt *,
>>                                 const struct rpc_program *, u32);
>> diff --git a/include/linux/sunrpc/sched.h
>> b/include/linux/sunrpc/sched.h
>> index b8ca3ecaf8d7..e9dc142f10bb 100644
>> --- a/include/linux/sunrpc/sched.h
>> +++ b/include/linux/sunrpc/sched.h
>> @@ -90,8 +90,8 @@ struct rpc_task {
>>  #endif
>>         unsigned char           tk_priority : 2,/* Task priority */
>>                                 tk_garb_retry : 2,
>> -                               tk_cred_retry : 2,
>> -                               tk_rebind_retry : 2;
>> +                               tk_cred_retry : 2;
>> +       unsigned char           tk_rebind_retry;
>>  };
>> =20
>>  typedef void                   (*rpc_action)(struct rpc_task *);
>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>> index fd7e1c630493..222578af6b01 100644
>> --- a/net/sunrpc/clnt.c
>> +++ b/net/sunrpc/clnt.c
>> @@ -2053,7 +2053,7 @@ call_bind_status(struct rpc_task *task)
>>                 if (task->tk_rebind_retry =3D=3D 0)
>>                         break;
>>                 task->tk_rebind_retry--;
>> -               rpc_delay(task, 3*HZ);
>> +               rpc_delay(task, RPC_CLNT_REBIND_DELAY * HZ);
>>                 goto retry_timeout;
>>         case -ENOBUFS:
>>                 rpc_delay(task, HZ >> 2);
>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>> index be587a308e05..5c18a35752aa 100644
>> --- a/net/sunrpc/sched.c
>> +++ b/net/sunrpc/sched.c
>> @@ -817,7 +817,8 @@ rpc_init_task_statistics(struct rpc_task *task)
>>         /* Initialize retry counters */
>>         task->tk_garb_retry =3D 2;
>>         task->tk_cred_retry =3D 2;
>> -       task->tk_rebind_retry =3D 2;
>> +       task->tk_rebind_retry =3D RPC_CLNT_REBIND_MAX_TIMEOUT /
>> +                                       RPC_CLNT_REBIND_DELAY;
>=20
> Why not just implement an exponential back off? If the server is slow
> to come up, then pounding the rpcbind service every 3 seconds isn't
> going to help.

Exponential backoff has the disadvantage that once we've gotten
to the longer retry times, it's easy for a client to wait quite
some time before it notices the rebind service is available.

But I have to wonder if retrying every 3 seconds is useful if
the request is going over TCP.


>> =20
>>         /* starting timestamp */
>>         task->tk_start =3D ktime_get();

--
Chuck Lever


