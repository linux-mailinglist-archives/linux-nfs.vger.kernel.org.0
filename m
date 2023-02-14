Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C4569677A
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 15:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjBNO7L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 09:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjBNO7H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 09:59:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B09E265AB
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 06:59:05 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EETtEP003678;
        Tue, 14 Feb 2023 14:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KbZIXv1ucrwUFtbXLEOTi05428ReIlrR/rzqrNiVbVA=;
 b=sHQJG5tGDyd8OjCq6z1JOiHaw289iGbpHWhQgTjp57aSRjEbusBDtAGJVGe/w5Y6eWM6
 X/gob00FDfuW3h6DNWYfBgHu345IBxmuNtpaX23Ygz4QjkIwqZN8V38sRen9avh7zRe5
 82BzUwyYFGVrRjvMpR5IJXf/wAau5IuA7Wf+oW7/1yZYNEleF87SWaDT24WJYJfqF6gT
 sn/16ZF8fLHsIJT/fvuP4mb2F39RgnkBJbARPlSVtO7aoLBd2e5UlU/Jjbfb1ck6ncvL
 /+farg471J5pMZrjXsvr/UMeeMpep+G76qxMAF0ZuA7CVHCU91101I2FSZL5ezz+NQfr xA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1m0wnx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 14:58:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31EDKweX018010;
        Tue, 14 Feb 2023 14:58:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f65u75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 14:58:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQLUKoH5F4qquQChYREsQoZnCdUyhQ983fxJMKr8DIUvmqQ9il1+38Z82FFs2vCP5d5/2SIf5vhV2eO3OWfY7TkJ7bKvwtYLlByq4hf3sM7phhitqeYOeEoCOeBRxQ+liYqE7XvfrQ6te+/vlWSHz+wDgrktjMZZUOrsv7DhkmonVhtx8ssHKQoU1fNxkbpoRkCbM5KhqWJpVilmOOzMjysYIbDbAyYCSJXhWTQbC/BGRVslAB/7bQxzL8p5QfMym0UaJ7fDfaPJggkUxv+UXCFEyXvYVf7CDFOXnadRp9HDpoxFlkdq62CFok5skUbX2dL76j2wMRWF+OqTz6NqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbZIXv1ucrwUFtbXLEOTi05428ReIlrR/rzqrNiVbVA=;
 b=YEO8Xr0UqoBxiuwk09V2H7KFNMCRXOuzXVC4g4dndIYYAkT+56Lc5fLryRu6Dn22D8QBJFBaUhQnk6VMFG4pVIKLKQ7QfcM4sOgsLBEdpg1E2p4e6aJEoH8g10uA/t+d9KhsLJlcd6EwcbyiHCPzo4km36uAFUhrST95vp/PHeyLHikdPUTulNw58b7yoKDqfL2/9yjY1zuQJXvCvjVBvrYkSrQdppwoexZ20c2N/taW6vGPDFRFtsucMdHXEkn15KOuZeMVZv9DzbqVvQBJImq2lBRnFfXTKfjBcz4zWcksxHedd00KKwxvoCvkie0nN721R2LeVyuewKYhHAWuvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbZIXv1ucrwUFtbXLEOTi05428ReIlrR/rzqrNiVbVA=;
 b=QrgPGDM8TrYGThPJ1QL+HIejvZgIgSHzZ1h+sZIi+q+Rvud/KN8JhaKWUP9eRgA6JA2AZBN4vvxhuOu444U2e0oYicGIb/FeXFJEVH0sp1snvXSLGhP8/UW5T4fDu3mq03H+giB7MpU8fu15V/geAAbqV3w8f7uXjX8nhfiGsbQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4547.namprd10.prod.outlook.com (2603:10b6:303:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Tue, 14 Feb
 2023 14:58:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6111.010; Tue, 14 Feb 2023
 14:58:50 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Trond Myklebust <trondmy@kernel.org>,
        Rick Macklem <rick.macklem@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] nfsd: simplify write verifier handling
Thread-Topic: [PATCH 3/3] nfsd: simplify write verifier handling
Thread-Index: AQHZP/AVtkfMbaZe202q+VCt515DH67NnHMAgAAskoCAAK6mgIAAEiWA
Date:   Tue, 14 Feb 2023 14:58:49 +0000
Message-ID: <2EB94DDA-0894-40C7-925B-C0068DEA577C@oracle.com>
References: <20230213211345.385005-1-jlayton@kernel.org>
 <20230213211345.385005-4-jlayton@kernel.org>
 <CAM5tNy56at7gvUBbc1T7ay=NZQ08qOaAxdux2ZB70sZdb3L0xw@mail.gmail.com>
 <5e19458b1eba1dc4c187d14ec0c74547acb6a2a2.camel@kernel.org>
 <bd23b795b30c5640a8c7ebbe98cee048cc4022be.camel@kernel.org>
In-Reply-To: <bd23b795b30c5640a8c7ebbe98cee048cc4022be.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4547:EE_
x-ms-office365-filtering-correlation-id: 4d490f2c-6236-43a2-85ca-08db0e9bfb27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rzCEROt3582Nc5jvvALcYMTErfNDmZAj2KhLwzudari8drfqaR6Y6GrlBf7n24F37UpgRf5b0G4iMpg5wRPaIlz6JTWWYti9oioVC6SZS6Lv+t84ObwiJ8eDLhLthEaHOTTTwltrLBHErSSt1v+p0H6TeogI7FiBf7rOX8jbqTNK9VaNRDKjLF7Od1STXSD1OhMud5L4MmTkz7I4ldXO/GBM5Q4OdHVZmLgivlbQ6dwGmNeHwGoQZ8S9zcvkvTloHSJlxLSzxH4tKT18ciY3dUSOxL2kTi0nZLUcOHTaEoFbjnUVF54+FGyOJ1jxJY38pI8mwq2mE2i8ZSMbxiAUd3mOenVchlvrZX2FBRrdRYVpBVnvSN3S1c4lpZdfQOjhH5oyICpZxHPRXQ4aWTODKjOmzqaxZSU4vMlg882HfkAG9V6IzVx/ybYI0YzKa8PEK6pIbXnKplHeDP0tT56bOcv6sycjOEROnNtaJ9I6Dv+atKOfc91chebTP1uxJIUjaoLrYl3YkSABDpQKp9M+A+y41z36fbJ4W8eSMCD8mIFvZm7vsg1HMrXrkvcFQQjP2LinB5kg0ut0Cf8kB/H5krzaZ8ajXDLFSU8igaQTsepn4i2F8WwJcEP/nHT+nSUW+StYFJWbWRqwllh5azzDrPOe3iRaN5BCIbas7FmfsGu43lmWB4R8Mcbi0T2TH9gp4VsWSje9nZDfNVEsQ7SsCkNzJAsLOF7SUDX5jIGsnX4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199018)(2616005)(36756003)(86362001)(122000001)(83380400001)(38070700005)(38100700002)(33656002)(91956017)(54906003)(316002)(966005)(41300700001)(66556008)(8676002)(66476007)(5660300002)(4326008)(6916009)(2906002)(64756008)(66446008)(66946007)(8936002)(76116006)(53546011)(6506007)(6512007)(26005)(478600001)(186003)(66899018)(6486002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n38G8M5L6eua9e1nWpCKQC/ooZa8jnHo7gy+gr+nlgOwQFUYwLs/9ea4wcAV?=
 =?us-ascii?Q?0gkXq9NOe55nzG2relxYtbrcT6S/UXTq58IHuaa53kKIvUF98iWzpCri8cNO?=
 =?us-ascii?Q?jnazYxno6tsp0jvvc68eKKVlcX2GM61og8yi6b5dP+jmP6sL94G0wO8K+VsE?=
 =?us-ascii?Q?dtCr2gnWcId11vDhrceAIEBZQIWO8MXXpX2TfN/nv4ohXaW8VXcCqyqxW8eB?=
 =?us-ascii?Q?qcPpG8XTeLat685yj1FIZpfVqYzony2IIllBuzdnZkI6h1qnBddWsDCXKEIP?=
 =?us-ascii?Q?iZfi0Ncw8k8h6fEj7GAmK1mzilOvNQ9tfomuaTtEA0Gh78Qd2t+GVgDIT6V7?=
 =?us-ascii?Q?67OId/TrZw0gUj0+kwYuvhn+N0FDPfaQrPhdPmUOgfKAR46iU7NQMJAz3U8h?=
 =?us-ascii?Q?DMYFLBzdLHnoiJa2Q06QW2lNUOfL20OEwlMoJIJyRhmYymSpaSQgfvd1Z5C+?=
 =?us-ascii?Q?ooODlMsWXgUTjmExiiSW8VZjXShIplzqpxMQ8CFqc5hyN48XoX1P1CLkK6zl?=
 =?us-ascii?Q?OsiAiwbITFYX27f3dbwbYBSj946AT7aWYx31yYt+0S43tCfHBOrGetgDR/xW?=
 =?us-ascii?Q?j5OaS+S7GpgwYKStw1C8nifb3Qp+l0mrPP6Qm2Scpv6rblFu4/wutUgYopC4?=
 =?us-ascii?Q?fNay3pS/ErcHgHpuTAnihw2uXbXs4PkoNgChEBuoHToPUG556ijgYIMY2ubG?=
 =?us-ascii?Q?lQeJkwQNJhTkbByzwgo0kZ0tpbPei2nAHLpap8JyalHxaEj6kkjZiKpqyi5+?=
 =?us-ascii?Q?gQ3G4G9YTJgWDUtxev9GHOBO/mtzfnYKRrvNBvdC0qBXl6fuIQ5AEQqYcWC9?=
 =?us-ascii?Q?DFnU/wG2sRH+e93BjGb2vRheXy4ZF/4oNoRt9+VO7upodQL7/RuDCiZnLdVR?=
 =?us-ascii?Q?cEKqSf6nESFxlr9prjeQyPJY7P0Mm196mZSu+FggeVYkB3YlzcE1M7rHgqsQ?=
 =?us-ascii?Q?o4eJoCBsnIkKqGFcge4QTa90iDOWoBXog3WUfJKtiJCKRRBtz7LAkSpFhPXZ?=
 =?us-ascii?Q?FJy45D7dipgXGXo5jfXKvVUBIZ0Yr4xFcNJISBO+Y4vUgCIkMcVPNdi5wXw2?=
 =?us-ascii?Q?AHH4i/2MQxFlCg42SI8f2cNKEoOQrtsHhTO+4a0cXrn8VT40XzpMpU1VeN5Z?=
 =?us-ascii?Q?1YVvTYMgDx3tF8q/5HWSekA0Dclc0gSxPoLjVSYci1liKqjZKGqEfLCpZ/eP?=
 =?us-ascii?Q?r7w5VbM0GAg1qGPAv5281hH0FuJW/U8yAVO7itp8iPv2zhb+EBd6hKx9u2oK?=
 =?us-ascii?Q?HaDijRQpG009ropK8Jj1jOrl5NahbjC2zzEsFk9PjndrZQ2B7RuyS9CFp8Mj?=
 =?us-ascii?Q?F3jirA4ETOIvuRtOiJnb6OX+9UxVxysWyakoQE/OCtrv9iZbUVNGXdgZWit3?=
 =?us-ascii?Q?+L7rZz5mKmgd+1UahmP+lEAmzAqjOgXe2MqZqFoHUhvpq6yjRJm89gNAAiJo?=
 =?us-ascii?Q?ilIn5v9WkT8nz0xWi1VCf+tTOgO95OrKJOYOZOV8GzcE7bdNhbZaSJft1L4R?=
 =?us-ascii?Q?g0+OrQRkx+YX4pgFG8dbJoPQgwld4YwLsJ8ADz15rReF9Jy9Y3J6vQ6JmdO2?=
 =?us-ascii?Q?QKoDxvZJbMczJP6VguJbdoR7v+WPbAQ/sHijJZKSAfVEx9Y8r9FQDkOZ8Gjh?=
 =?us-ascii?Q?dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E9C5ABE76F9A549AF74A3A21DDA307A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8ERAOaR86/mJ2vsAsBPTh4pP7jQWcGdVGnzxfIOvHjO696CokJFO6uw+P0g4jXuw91rXf1Pdv1b+vZUfEzdvJkjsqpnwprrAWn60ic9b1qvol3hx64evaRhc0M4nxVL3BtCLKDET4H2c0ySWpEnEMfSADMMJgD2smNvxHClm2Dqs+UuXD4fBkdiabmzR4Tzp3hzPIiKMUd5aJ6u8L56EWOigqul9hJAxuM1C8Mj435LQgtTr+akrn5oc5MyBlSht26YKaJbAIjDxqI8QuWkFZ3EVXH5VOHAFKSbh7kh7BVRr4O9ptSSJJm9EgwWASGBNDh1IYSeoPvRH7mQPy6eKbuodFW6c4WTPcffkYciDw7QtjH46k6F6BHz2RB7BYlqikYtgeOMEi5gxFYCiiaSkO5645+bpZ2tiwor+Mwrhe4H0Ga8gHIstQVMsd98AsMcjrFW1DRZS59CezDjCBQeM0Xj4JC91o87Wx8fSiCUiwMFYfIa5akuFGDo+NT7zcA9wlamcy3OSAFhyLYy4FX9NXK3pgp7KCq78QAmNl8ywoq8//qCtRhkbM0uA8MaPe9pazjI9KmmgHum4UGXIebJ1xpJVlr76C9AwzhEr4LZrdTHoWhmJgDqnav2G2COT9lae25j2jPmarQvrK25MirwlKRIzcfspvt9XdW6imcw+tWvw/seC6FbVn94rnuJWmxi+YHwczRJZo7xpWcLgcCqXh6IX2C1TGyy8txpC8Psr/cjEzpkOTRaVuG00egOJvaJ+DCIMe1BXsciikzlZtXOxVgPo4TbOq2iNLsE3KZOjiOJGJlwIxTXwYPBI1RSIWiLEIdc9EN012uv2v7k1zaOTDptgX4h2OCRYu4hj4iNM70E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d490f2c-6236-43a2-85ca-08db0e9bfb27
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 14:58:49.9292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zg82wtyAR3SCcOEtmaB0Qj9qKKH4rM+ErnCq23TPWMQ1u1IqVl4bGN9CxiIwXOX2HpG+hXPyPKJUmnHaD69/HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_10,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302140129
X-Proofpoint-GUID: kA-CqMo-kiVQL6KY84VM04C-64pj_H18
X-Proofpoint-ORIG-GUID: kA-CqMo-kiVQL6KY84VM04C-64pj_H18
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 14, 2023, at 8:53 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2023-02-13 at 22:28 -0500, Trond Myklebust wrote:
>> On Mon, 2023-02-13 at 16:49 -0800, Rick Macklem wrote:
>>> On Mon, Feb 13, 2023 at 1:14 PM Jeff Layton <jlayton@kernel.org>
>>> wrote:
>>>>=20
>>>> CAUTION: This email originated from outside of the University of
>>>> Guelph. Do not click links or open attachments unless you recognize
>>>> the sender and know the content is safe. If in doubt, forward
>>>> suspicious emails to IThelp@uoguelph.ca
>>>>=20
>>>>=20
>>>> The write verifier exists to tell the client when the server may
>>>> have
>>>> forgotten some unstable writes. The typical way that this happens
>>>> is if
>>>> the server crashes, but we've also extended nfsd to change it when
>>>> there
>>>> are writeback errors as well.
>>>>=20
>>>> The way it works today though, we call something like vfs_fsync
>>>> (e.g.
>>>> for a COMMIT call) and if we get back an error, we'll reset the
>>>> write
>>>> verifier.
>>>>=20
>>>> This is non-optimal for a couple of reasons:
>>>>=20
>>>> 1/ There could be significant delay between an error being
>>>> recorded and the reset. It would be ideal if the write verifier
>>>> were to
>>>> change as soon as the error was recorded.
>>>>=20
>>>> 2/ It's a bit of a waste, in that if we get a writeback error on a
>>>> single inode, we'll end up resetting the write verifier for
>>>> everything,
>>>> even on inodes that may be fine (e.g. on a completely separate fs).
>>>>=20
>>> Here's the snippet from RFC8881:
>>>    The final portion of the result is the field writeverf.  This
>>> field
>>>    is the write verifier and is a cookie that the client can use to
>>>    determine whether a server has changed instance state (e.g.,
>>> server
>>>    restart) between a call to WRITE and a subsequent call to either
>>>    WRITE or COMMIT.  This cookie MUST be unchanged during a single
>>>    instance of the NFSv4.1 server and MUST be unique between
>>> instances
>>>    of the NFSv4.1 server.  If the cookie changes, then the client
>>> MUST
>>>    assume that any data written with an UNSTABLE4 value for committed
>>>    and an old writeverf in the reply has been lost and will need to
>>> be
>>>    recovered.
>>>=20
>>> I've always interpreted the writeverf as "per-server" and not  "per-
>>> file".
>>> Although I'll admit the above does not make that crystal clear, it
>>> does make
>>> it clear that the writeverf applies to a "server instance" and not a
>>> file or
>>> file system on the server.
>>>=20
>>> The FreeBSD client assumes it is "per-server" and re-writes all
>>> uncommitted
>>> writes for the server, not just ones for the file (or file system)
>>> the
>>> writeverf is
>>> replied with.  (I vaguely recall Solaris does the same?)
>>>=20
>>> At the very least, I think you should run this past the IETF working
>>> group
>>> (nfsv4@ietf.org) to see what they say w.r.t. the writeverf being
>>> "per-file" vs
>>> "per-server".
>>>=20
>>=20
>> As I recall, we've already had this discussion on the IETF NFSv4
>> working group mailing list:
>> https://mailarchive.ietf.org/arch/msg/nfsv4/99Ow2muMylXKWd9lzi9_BX2LJDY/
>>=20
>>=20
>> That's why I kept it a global in the first place.
>>=20
>> Now note that RFC8881 does also clarify in Section 18.3.3 that:
>>=20
>>=20
>>   The server must vary the value of the write
>>   verifier at each server event or instantiation that may lead to a
>>   loss of uncommitted data.  Most commonly this occurs when the server
>>   is restarted; however, other events at the server may result in
>>   uncommitted data loss as well.
>>=20
>> So I feel it is quite OK to use the verifier the way we do now in order
>> to signify that a fatal write error has occurred and that clients must
>> resend any data that was uncommitted.
>>=20
>=20
> Thanks, I missed that discussion. I think you guys have convinced me
> that we have to keep this per-server. I won't bother starting a new
> thread on it.
>=20
> It's a pity. It would have been a lot more elegant as a per-inode thing!
>=20
> Chuck, I think that means we'll just want to keep patch #1 in this=20
> series?

Regarding patch 1/3:

"sizeof(verf)" works as well as "sizeof(*verf) * 2" and is a little
more clear to boot. You can redrive a v2 of your patch or I can make
one. Up to you.


--
Chuck Lever



