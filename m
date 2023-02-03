Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D58689E60
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Feb 2023 16:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjBCPfn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Feb 2023 10:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjBCPfk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Feb 2023 10:35:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EA86CC94
        for <linux-nfs@vger.kernel.org>; Fri,  3 Feb 2023 07:35:39 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313FOH1g011952;
        Fri, 3 Feb 2023 15:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nMjO5RN6zrPQihMopNm0b9ujnVJb2IsmMqFothD9ZkU=;
 b=lkdWiN2PNxy3lK5cVdopj5TW0k5RStawjhFpKMMzdztxXoNGVszfsaCutEfs4zRxiTNi
 jfa4Eg3tvPB4AXH1DnCDidUHWdTZvL/vJ2Gz0ohgbLA59G73kZ6wqRNEclLSBNNTfN5D
 crVJq6Fpu9D4JQ5uPRDv9kHoLMn9fnKPvDpBmBTt8lN47+qGLthhsS2sJjNGqG+my3PV
 rM7B7Vsjacr99EvmO/sYdT3hghh2fyOYR4s4PdTFQX8NFypKie4shczFqs0X/j9apedT
 lqmbawHDNkJjFu6RwDwRDU997GMKgjSpaTBQ11odU/hqZAFvFBVkEL6qlWs9rEdNoJGN 2Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfq4hnkfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 15:35:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 313E2Gi1040609;
        Fri, 3 Feb 2023 15:35:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5anrmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 15:35:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nbihvziry9nRGx0Le4SsOOGbfRCV2YBrBghlitZ2tblACJonF3BFNQQ72FLGb9b1+CvFtYyv90r33z6Zo8ye19ANan0HlciVNMX8zbD8Nni2u24kINvSowhRTKbr7IBnA6/Q00xyfmx2gzph4Np8xRSbXnPBeUEPXzUaKFHSqCheY7njx0ikHe7G7gJLrcHWNGA9WA5F0AfpOr7hv3Q4cQb9kSnfBdm3815uTo7bxoQMXbt40JNz0OAO+EQwJ4axfrNxWu0oYLLFm/gg8YZUhSZbKvXe5o6MWtRB++m35fkDUoe/qUT2iOjE7VnZvBCImRNGd0Htrqp3Qf2Cc+pK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMjO5RN6zrPQihMopNm0b9ujnVJb2IsmMqFothD9ZkU=;
 b=bN+0v9RRsYBuzPCi79vHmdoTXzNiuJ/3xZ86hIlq913FsGcK6f1mgQkRpHsvOkNeCeaIX8EYR7Gi8w2zJaB6tCyqjv/pdpQDr/XDWElRCkt21AC8dhAHZrDoOT1vYwn4ZV53XjOmp+GM3E8tQ4rGE7d5gDQa//47j95/CQDUwJ7EE9nY8cLl1Ju1aIDsw/bUxU3ZTffJfUWJuzv3vUxt6qLSdBkdIWfiCLYGMd/c+U8CnAk16LapcOVONIFG/TS/mW6rjtQc4ZCNc5IDA7GUApU5Uyr1MqJeJoQ8Fred5WWRmcFXAfo7DqiarIe5JhlLXuPAP7kpd/VjxmPKOVxz8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMjO5RN6zrPQihMopNm0b9ujnVJb2IsmMqFothD9ZkU=;
 b=zxeL31UdLfULMxa5oT+7++LroBxeAO653ks28GQ2yrhLMN75RhAi1iFvkTZQQwUmTM8CIg7Ub8CtmpgYQMCbZ1nFS2prLY6+VmX2QD7SQngoyvW62y8zxcPRmMCuaP4lzTiexhwZ9Obp1R7x6A6pQ/UkhSDh0GQ0NSRnPgb0hDU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7037.namprd10.prod.outlook.com (2603:10b6:a03:4c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Fri, 3 Feb
 2023 15:35:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%4]) with mapi id 15.20.6086.007; Fri, 3 Feb 2023
 15:35:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: Re: git regression failures with v6.2-rc NFS client
Thread-Topic: git regression failures with v6.2-rc NFS client
Thread-Index: AQHZNbksRLoeBCG00EyL+s5Kt9KD6665E+wAgAEOhICAABzOgIADD6eAgAAJrwCAAAZBgA==
Date:   Fri, 3 Feb 2023 15:35:28 +0000
Message-ID: <1AAC6854-2591-4B21-952A-BC58180B4091@oracle.com>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
 <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
 <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com>
 <F1833EA0-263F-46DF-8001-747A871E5757@redhat.com>
 <B90C62F2-1D3A-40E0-8E33-8C349C6FFD3D@oracle.com>
 <44CB1E86-60E0-4CF0-9FD4-BB7E446542B7@redhat.com>
In-Reply-To: <44CB1E86-60E0-4CF0-9FD4-BB7E446542B7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7037:EE_
x-ms-office365-filtering-correlation-id: 0079ce3d-0c6c-414d-2948-08db05fc46de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xds00Pn5O+bLy0J0+k7dwbgFOJLQ8lLD7H31s1+pYXLAZb4pV+TUz2bURC+763mPOf4jI6AYdEs8+7pH5f1Z/LKzhZ0WNWsotkXNrxvSIbfxn6VYjDjyktyXjFZzbHKEDmfejJlM3dQeh44yWVwjHAj+W5M9VSVwOh9F/GMrj7cFaiCgrr5Df+d0oe5a0QAsUiTURx2RqxQ76TQEfFzbNvlgb1/IxUyxzoq0IXpNlssK54PrOt0mjRkp+auHoIkwgMkKtSERrOwsY7V45IvQLshEvGJzvnsH1PUJ6zVoIld3tux4LTW3CC1sq3UPOAIiiNgx9yfrQL+ugYkhx+B0spP2YoDSgh6kqtnhz6SQ93yeFcUOds7fkbgwqqhB/I+iz0M1x1vMD6kEndc2z6W4dbHSAGJSXHtkOwg0xBE4pIwrI6zdOF5UECIcOGIjGJwZVqKKlXUs1iAuTmA+ew3jfxrnaHZdQj9jL8DxYeoGHMa6+tzp53aAm4h91D8NrlN6kz2KZDOkloDDl+ilrDuu4ig7ziiUs5hQj5sto04+XCoaSlTLRdWvK2dlQBS7PauaNWgu1gsz2q0p5veif31AsE4f88R6UdVmvcfGaVBXqhfKY16IwbSmkpi1M11JKeh7Soa9VCp4G2LJPFyy1WySd3gkau81xaekiwRKbpKgG41j9lAv2xuCHeGwngLXXcr8NXbpXgq5cRcMwEFF2fVIWOxWPmWg+cPjMTimx5gZCkUwpKY/frigpMMhOHu6OLcKoozahIj1r44ojki0kg5lcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199018)(41300700001)(33656002)(71200400001)(83380400001)(91956017)(86362001)(38100700002)(38070700005)(122000001)(2616005)(316002)(478600001)(66476007)(8676002)(26005)(6916009)(66556008)(66946007)(66446008)(36756003)(966005)(76116006)(64756008)(53546011)(4326008)(6486002)(186003)(54906003)(6512007)(6506007)(8936002)(2906002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Uu3rQuqs9QzMnTtee+ABCwb1duazWUbbi++zmwxNTWjwpPg0uf/lDhYp5Br?=
 =?us-ascii?Q?wRdk4+U4lYx9NAJQYGIrMkhwMW85X7mNhRYOGMD5JeWoCSugenO64T5hJiAI?=
 =?us-ascii?Q?LMRXEQfwxwsiCr6eEsJCnytDz8j9vN7m0LlbzyPE2gzaQ1ooYGI5bhd/o2eV?=
 =?us-ascii?Q?EoVVO3xuF/Z/DnEfc/P8GM0BwQ27rrlIYKka4RN1VSA2eUQAuTq/EJMfqwLE?=
 =?us-ascii?Q?y1TmDoOOCCHn6lryNdW1UFw5qvTcrXBd7BqGt7e5KqYUDZ4Fqz66kxNJB9oV?=
 =?us-ascii?Q?ez/PWu6/hZl8nVYjyjrGtnx6BVvYg8nOBDEhqn8pAm3twSQ8Q1THzry8HToN?=
 =?us-ascii?Q?W6cbAtYjHu0Xok/ES0HPUjJS6JOTa85UqAvQ7NwwAMs48Td1FaW1vG5Q67lP?=
 =?us-ascii?Q?TKE8aBOsXEDFGFsSs3Sr7/0aLjLNTgwLfnmss9ZuEC+xjPH5oGtQ6sskxZ/u?=
 =?us-ascii?Q?YGnQ+LN9QJbhmUjric/Q2FxW3CCwR9v05AF8mAcpBRO1DBOU+RSmLvpOHLtG?=
 =?us-ascii?Q?TLUPEi+tMKI8DRiX0QSzyGlAqelGiiU34zCeguR2CfjmJhLLRCXQWHlltFRB?=
 =?us-ascii?Q?MzQN+kLdwNKc81WZ2gwR98+eRcDSVLzyyovnW+mtDy6wilhFH046wdyvebGI?=
 =?us-ascii?Q?CydnSHIaMKT59I7WYoqdk+uBFIzH8ipaFyyZlhs4NIUD3qFSUvPP0iwTJZrQ?=
 =?us-ascii?Q?Cpc2rynJxM2+QvOllWPfSeCGQKQYPrkiZVBnq31Vi1WyyExJnPwbTS0bj0Rs?=
 =?us-ascii?Q?JWeO0DsfyNH9wri/oER4Ih6fEa50EwYrLqT4WHpMZqopYoFiGtZ5fEMGnTZV?=
 =?us-ascii?Q?w7v5877cSDboGb0y+y4zKVCnBD/Nc+mpbxYQ8X2XmoG9xTBHGFRkNDQP0eR3?=
 =?us-ascii?Q?pSI/rTxil/MN4TVbAeLC2Nz2/xFUxNZ0aNgqQD/q4En7SmQdbmPjBV0/8zJP?=
 =?us-ascii?Q?mxyvCHNLaolymH1wW9gv8DOLh1QYNTkrJI3RvxN6rRrxVPp4t5q1yK5YcR2x?=
 =?us-ascii?Q?GZn/tjLq9Fon2Gy/SAj7OMlcZ9nB3UL/TU6I+zS76wdVJujY2cDj7QlYluYS?=
 =?us-ascii?Q?QsuYy/Bs399+vuHjHcpY9ECA02SP8lAR5w9WYyGI3N2RZa5pb+6ts9C4aIVb?=
 =?us-ascii?Q?mvP2hmOgmOU0VuHwlyaGApHByBy985Rt6AcD4NfheKTkHg6UfbBtCn1Dmxg5?=
 =?us-ascii?Q?WTF0fA2Cig5R3AZFGGz3OrSlyU0b3aqZJ7VDJVBKd3/S10d91zCDKkuEZyaV?=
 =?us-ascii?Q?VmpG6MyNNA3JJDq9AhDsbJYWs/rWqUV2JAmgcett2TJLGhwgRQccA767mHt9?=
 =?us-ascii?Q?UUeQtbQa33Pc0g8d27heD9qgAwcF8A5RNPeLhBLhENENaNkPEIwXPZnyP+/r?=
 =?us-ascii?Q?fHpShNY3R60R3auz7w2mWCYnEtwQ2//5x5KvSxMhXEb/IrzO2BdxrjtU8ajI?=
 =?us-ascii?Q?EfLCPFlSRL1JArSbh1+hv3QpAxnL1eUTo4+xF82xMqlL/AhcvDvv+2MnMo/Z?=
 =?us-ascii?Q?/yzqVXZEhuqyDVDzGaN0Y0zL70t7RxYXM35JnUp4mbfJ+dNGe2MetQXhqJmv?=
 =?us-ascii?Q?T4uGwEzwzODWvVL7Nf/Td4jFdVE9Wt2YZjafh+E635DF2zxtL6tQzNzkyAmM?=
 =?us-ascii?Q?oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E08D1A0FB1C2E47A895D9A76E5F72B5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WExQ1DasivptYDEo2WFt4EAETtwvWClcpFF4UNRqyQNTcfDEazWfjcXNh/jKxz56pztzPOeXjvJLZz1eLATOixLa1SlO+7oJbLB47U5YbKeiTtCPPX93gQXruMT2n0APVwFuT/1FAU8P9H5HXvA995rlirzVrK5R7hLXgXrq4qdhuB/0Id6VqJWVIBGufUBwdm08GUCwdTQcqETqRFwJmvqsEFhogjxm1XfI43tFlGsP6VStRj4Z6f+ngZM9Q0YOPxRRYUaqq+t5Oj4nQaV5bBxIUjLie81RpOgRf2qkBwBteqYCJ4drGYWT943Hg0oEe7z6CwthMAZuuS9ThvLincgPZdAdyiHp/BL7wpMzph3oaN+c0nqiUpgaqS+WL5KBeE7mx8kksS0fO8xM5e/EeiOpci1Mk8tZb4mlYW+jtoK3KV3Wtm6IDJSZlS+G7tRdHlD7qqcgEQGhu02nfnpEPNS4fZlpbYeDa8PjLGzrR4M6lNCfwciJ7BtU2VNMpBvYWnVIgl3T8APEmwmkuTSu7KxMx9w2AJjnpOHCzV1gbl0kx1keS4TOgmrsgbo6MCgN46QBqRDdaBdAXBSGhanguZjY1xrzFv8bLlgyFQImEgQQT0/emdnFSjwJ2p7CuSvxWOcj86URdkov11rvvnEJeky3p3jlw6TFZTcmvwUMcb0j4eqxrIwB2dW9ovYqz5CbCXNp4fhm3gAnOdGM+233h9wP6196DVWYev0ZA4HFTjuQdx4i/M0xaZy5G8XwUqTzkuVgO1zSHY2W48LCuHk406TUg6beNlcpfjgiJQIqXxg/Fyy7e7lIGRGLUgk03fYfyxl2t0nZtgWd4Ok2ur6mVld3ORcZHbsU4xsxn/jpUmA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0079ce3d-0c6c-414d-2948-08db05fc46de
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 15:35:28.1763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZK9+1aOiiI7O/Si+ZRpxKPwMGdsbUH/BMY/w2L21ICa/c7DPxu81SCUpoinzMRw1n1yRGIkkrdZpv3++t5i6Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_15,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302030142
X-Proofpoint-GUID: nvuZSB9g6lq8Zfak4bsxl2XrFjnQfrzu
X-Proofpoint-ORIG-GUID: nvuZSB9g6lq8Zfak4bsxl2XrFjnQfrzu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 3, 2023, at 10:13 AM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> On 3 Feb 2023, at 9:38, Chuck Lever III wrote:
>=20
>>> On Feb 1, 2023, at 10:53 AM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>>>=20
>>> On 1 Feb 2023, at 9:10, Benjamin Coddington wrote:
>>>>=20
>>>> Working on a fix..
>>>=20
>>> .. actually, I have no idea how to fix this - if tmpfs is going to modi=
fy
>>> the position of its dentries, I can't think of a way for the client to =
loop
>>> through getdents() and remove every file reliably.
>>>=20
>>> The patch you bisected into just makes this happen on directories with =
18
>>> entries instead of 127 which can be verified by changing COUNT in the
>>> reproducer.
>>>=20
>>> As Trond pointed out in:
>>> https://lore.kernel.org/all/eb2a551096bb3537a9de7091d203e0cbff8dc6be.ca=
mel@hammerspace.com/
>>>=20
>>>   POSIX states very explicitly that if you're making changes to the
>>>   directory after the call to opendir() or rewinddir(), then the
>>>   behaviour w.r.t. whether that file appears in the readdir() call is
>>>   unspecified. See
>>>   https://pubs.opengroup.org/onlinepubs/9699919799/functions/readdir.ht=
ml
>>>=20
>>> The issue here is not quite the same though, we unlink the first batch =
of
>>> entries, then do a second getdents(), which returns zero entries even t=
hough
>>> some still exist.  I don't think POSIX talks about this case directly.
>>>=20
>>> I guess the question now is if we need to drop the "ls -l" improvement
>>> because after it we are going to see this behavior on directories with =
>17
>>> entiries instead of >127 entries.
>>=20
>> I don't have any suggestions about how to fix your optimization.
>=20
> I wasn't trying to fix it.  I was trying to fix your testing setup.
>=20
>> Technically I think this counts as a regression; Thorsten seems
>> to agree with that opinion. It's late in the cycle, so it is
>> appropriate to consider reverting 85aa8ddc3818 and trying again
>> in v6.3 or v6.4.
>=20
> Thorsten's bot is just scraping your regression report email, I doubt
> they've carefully read this thread.
>=20
>>> It should be possible to make tmpfs (and friends) generate reliable coo=
kies
>>> by doing something like hashing out the cursor->d_child into the cookie
>>> space.. (waving hands)
>>=20
>> Sure, but what if there are non-Linux NFS-exported filesystems
>> that behave this way?
>=20
> Then they would display this same behavior, and claiming it is a server b=
ug
> might be defensible position.

It's a server bug if we can cite something (perhaps less confusing
and more on-point than the POSIX specification) that says READDIR
cookies aren't supposed to behave this way. I bet the tmpfs folks
are going to want to see that kind of mandate before allowing a
code change.

I'm wondering if you can trigger the same behavior when running
directly on tmpfs?


> The reality as I understand it is that if the server is going to change t=
he
> cookie or offset of the dentries in between calls to READDIR, you're neve=
r
> going to reliably be able to list the directory completely.  Or maybe we
> can, but at least I can't think of any way it can be done.
>=20
> You can ask Trond/Anna to revert this, but that's only going to fix your
> test setup.  The behavior you're claiming is a regression is still there =
-
> just at a later offset.

No-one is complaining about the existing situation, which
suggests this is currently only a latent bug, and harmless in
practice. This is a regression because your optimization exposes
the misbehavior to more common workloads.

Even if this is a server bug, the guidelines about not
introducing behavior regressions mean we have to stick with
the current client side behavior until the server side part
of the issue has been corrected.


> Or we can modify the server to make tmpfs and friends generate stable
> cookies/offsets.
>=20
> Or we can patch git so that it doesn't assume it can walk a directory
> completely while simultaneously modifying it.

I'm guessing that is something that other workloads might
do, so fixing git is not going to solve the issue. And also,
the test works fine on other filesystem types, so it's not
git that is the problem.


> What do you think?

IMO, since the situation is not easy or not possible to fix,
you should revert 85aa8ddc3818 for v6.2 and work on fixing
tmpfs first.

It's going to have to be a backportable fix because your
optimization will break with any Linux server exporting an
unfixed tmpfs.


--
Chuck Lever



