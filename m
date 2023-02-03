Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57640689C04
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Feb 2023 15:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjBCOii (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Feb 2023 09:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjBCOig (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Feb 2023 09:38:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143E4305C7
        for <linux-nfs@vger.kernel.org>; Fri,  3 Feb 2023 06:38:34 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313DF16O028477;
        Fri, 3 Feb 2023 14:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qWPclLT1zSKL99PwyUfeDg+eV8AXfsqrb8HmgMWeSPA=;
 b=P2jBA4NLMA9CT/U/xAuLf0qIdnwj46vtJFgIuK2pijQLfdNUtFp5ZkdZkCJQwCB/iDoI
 c9CN0FZ+h9QkZGtp0/nJQVrDKtWwZfou21vi3DUA5uukysto0+P3ysaMKlxfXCJ78NUl
 YbobBWbMLbXw7Z8oE1Jr+GU7l9HH3OPnFJ33nBvJAKWRmgmUx3PvTJ3aSi+K8e8p/7//
 7uDM8ViiDEY/LzBh8I6P146wzC7yOmV3cV9p/tIovLD6WePBfzgCzNzKWrw9yyJYjO9F
 MVtLYMYh5PxYtcrCz07C7264H/Svx7/FNYdTNHEpFEBVz1SKHcV5rlB+cs6YH1PV1CrY 6A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfq28wdpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 14:38:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 313DJVcJ004970;
        Fri, 3 Feb 2023 14:38:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5hqfct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 14:38:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA7nkwlEGwxmNiTTMSSHewS+XqKHZ1+gkHdgcm3n9vgcFM86D5rSQVu8OE3Knw9zyzX13CwkkOgeao+qnUHo5dRpRp1MccLTajG0LDOvHAP4UWdXutBJvKfKePxrTo9PmoM7uMwLc8fN24mggT2bhSWa9Im7ESUlMv4g6G+p50czd2Q5SYj1PDzylt9HK6bw/2xmbt9KgBqQnyr7PUDot7scboeOVb6xa7Dlp8ECAtUcBAgWihWAkPXTRRqaSS4zNyta9WDmP8cB+pv5S4sDa9O5YL7ZMgsYyX4saQKgYO/98McmQ5jnM90R62am9O9WG1mFgrX3JhaViVDvYLqFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWPclLT1zSKL99PwyUfeDg+eV8AXfsqrb8HmgMWeSPA=;
 b=M6/vglYIc3IoHxqSN7AsFNNCIhxSwxPNgiSQrthgJbCO65LqrUTKUioAhNENVr05BBSd8ZVZbjWSiJ934j3wAYwbkdEkotLt2Ldg2cWlJUUO220xuClKZhFmaLcHyxFNH2fSDbqiK+DZuYCUUYj5vDDA3PK2h6RSSVgFImxcp72RVkc877yrOudlvoZ0YUzQTLzSmnFQgwUW7CPII2ZXyttytkxyR2wLnibGAitUYL5L8yVdTcw1brwHilBtAvVKdmiXskWtj01q4V8n/SZID9MNxM0Sl/HLNMAaLEC7gXb/lmiHlr+n1Opyqw3Yi1fNn/5E6RsC9dmPri2zsxPonQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWPclLT1zSKL99PwyUfeDg+eV8AXfsqrb8HmgMWeSPA=;
 b=jc9uvIhmdY/t+C2xUwvqefv8jiHE18IpLOJZ4eWPRW1dQKMQhd07YLQxEXSLoMTW7m3KFY1LRzPkWCvrJlIPlLMHxlDti4QYa1mOPWfizpO7d/ZuHy3RucCRzS78J/a++wWFxzSWnHvF83k6LGVGEP2IcMVx4dK8ZGaoEJfUThE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5064.namprd10.prod.outlook.com (2603:10b6:408:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.8; Fri, 3 Feb
 2023 14:38:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%4]) with mapi id 15.20.6086.007; Fri, 3 Feb 2023
 14:38:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: git regression failures with v6.2-rc NFS client
Thread-Topic: git regression failures with v6.2-rc NFS client
Thread-Index: AQHZNbksRLoeBCG00EyL+s5Kt9KD6665E+wAgAEOhICAABzOgIADD6eA
Date:   Fri, 3 Feb 2023 14:38:26 +0000
Message-ID: <B90C62F2-1D3A-40E0-8E33-8C349C6FFD3D@oracle.com>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
 <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
 <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com>
 <F1833EA0-263F-46DF-8001-747A871E5757@redhat.com>
In-Reply-To: <F1833EA0-263F-46DF-8001-747A871E5757@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5064:EE_
x-ms-office365-filtering-correlation-id: fece572a-c16c-414d-4c9f-08db05f44f38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s+4kU+cGI7rxRswEc3J3AFV679wPQGSMBuUZ6uXqCJR+fQRKPUnahhlZZXHMZnxKV+4YqEc7t09uvpB9bdQJL29zVJG60b730Z+lP17sODe54YxQiEsgpcaEHcVRgrW9Pk86SIc8JuuA/vjFQidYvaRu+rPprapo49z8kM0jh4gO7kH9NqgF9A8+c4J8TNDNVY5t3W9MQpRY2NmMYiZlk4HlEMqXL6B7DX2wQJ9T76rSbeO5xA7S7Jo4UPYwmtvgtBbbD+QzRTo6kGUQRNRn8w0O85saY0Q08mTaHhp1Qk01x+oGWT3uKk1cnkc8z9xEcX9vCY/kgFk9UEH1L8fUGeFyH/rvK8VzeE6zFteAT90b1aEWzUbjh/c+p/ODJD1qJ9lWN6TxJOD8IsN4TXoRQE/yIoH/y9WsoAQIS2rPWo6CuFx2Oxlnq4W88OoEztV6q5bHXsiz+dbunCpotOxzYM5JBZuuCKzHuwYYCB/1wOuJU0QtDvtqWQEAlB1TPoHXOQgVe8plAls0aw0HkRQgQpcfrsFJ81ytDdl8h2K2t/lZHNtENxwtVuI/cDuUq1ztf9uGW7pW/I3nphyn+PsPP112dxKP8DopmSju10FD+yS6tgpMZAO9CSQE/AQTmzpGbaiP9eUSdGq0aU5yokXFF6KVkAhV0s7gBwUxR9yFIoTFC5ynP9MKLfAjSd0uhWtdtcjQQ7rIXZVIJrbtw6dOWXEnkihzQeBDUgTaHUCoENFxUh4n6vyhM7MKKNHqTZoWtlGzwGVksV1M8Pf2FHPjEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199018)(91956017)(2906002)(36756003)(76116006)(478600001)(86362001)(66476007)(38070700005)(33656002)(6486002)(6512007)(53546011)(5660300002)(6506007)(26005)(186003)(71200400001)(8936002)(41300700001)(966005)(2616005)(8676002)(4326008)(83380400001)(66946007)(38100700002)(64756008)(66446008)(66556008)(6916009)(122000001)(316002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gUgo2959iMPiYNJVAQb33jO+M6CpyCpa5O2RePEX+6pwYu9G/Yf+zZopt6zc?=
 =?us-ascii?Q?Pioo1fxD7thhAyWONpZY25A6VW8Ra0x+rhzToRpvpARSdv5/Qv6XpIYYbCFn?=
 =?us-ascii?Q?HsnERralJQbbwO4rmr477wLp+yXGK15z3FuoUzyAQz52fzDykJBWn9TpNANM?=
 =?us-ascii?Q?WsPsLhFKLQAkgwep8HVm/0o/WnPgLqs8BMjlelpLEod92F2IalGuNKou8oh0?=
 =?us-ascii?Q?SpFOrkdDRE3SQu9bngH78XE06yf/xWZ3FunD9hsjt4uj/TYFiXKBSQN0jtCR?=
 =?us-ascii?Q?FAtPYQd7GQqfkf0UZCOJFxiQx9BZ8fG6CarEjbpsS8GWNHWQpFxJmABhkGRL?=
 =?us-ascii?Q?7bwMVFoYM+uYNQ1H6RkLg6OEQKt21W+qq9jv3OFOt6fGCYqkoRzhKtbX6+pi?=
 =?us-ascii?Q?5dxYLMDNbffxHcuGHUC0R4TMobALnS26kKAfUNnyuxNZhec9rVBSzt2DEZOP?=
 =?us-ascii?Q?3xGbFij03J8FYi7NRH9w4eTbpN2ZNRdF/ohF/ciwla4TghwTEM1jVPwk9SoU?=
 =?us-ascii?Q?RdEjnTOd7voVuVlrZHOFSHQjWg4Fjc0FRk8imvtASVXa8ueaQuozkHiqmNSB?=
 =?us-ascii?Q?ruFXB/79I/78H3syjbCdj510Cj007TDx+/WRqkksN+ZdCdsyORxVl/4Uw7NG?=
 =?us-ascii?Q?MLiVTZJ9Z5YP0p1BL+HsBgGhLptzU9gQ8LIlqxE5ZUupvesh9Ce+HhFyYDXZ?=
 =?us-ascii?Q?MTZe7gFMGOggJ1nGmDzUlyVFzwXk+KhmN7L+DjkDuvjNoIrXMunixq/HuX3K?=
 =?us-ascii?Q?wPTXgtf7KmjIBL72UCwl0BSPSUyVFbroJvmnz1EtilYs0LwtlgTESIIIIErJ?=
 =?us-ascii?Q?h5t2nm0nxNf7+VkrPXCRVvFe9cKUx8AP0sJ6ECHjvhhKVyBDTlCbW7UUQ4nA?=
 =?us-ascii?Q?BT0sdgklWsOb1gcr5PvxJ+1yE+9NFqFVcMMU840Pv3CTd9q1vZAouOYV40hj?=
 =?us-ascii?Q?qX7KUNn9TPsePpNDnSoIbMf6OlMS40LStAVN55KsGNxi38HOkXLCGsqiGn9R?=
 =?us-ascii?Q?NfSCz1YR8t5kt0R34YNUI5Ak8Y5w+O4U//WEB70HjSd6zAOAKFDy1nYLMoEF?=
 =?us-ascii?Q?Vv0LiFt/czDqkL26H3ONeZoc9pTjcgZYcpVtLBbGoi7/4QpR0britz5arQF0?=
 =?us-ascii?Q?ir7GTyIPPEuSLcJn4YTXS53p5n4IFmirps71v/hmz+tuBH/tR6U68VLYr5RA?=
 =?us-ascii?Q?qw5p6RMFe8lNp8U9NkKYt0LsvBoT/LrmxjA5VDib/3Tl7hix+LM/EVOhECpX?=
 =?us-ascii?Q?nivcHeI0J1sAsPgodMQRkmEb4cBDrlWdYOHGt9HvuKy4oVpVmh6ixjwblgml?=
 =?us-ascii?Q?FDWdlvk5KACYF1JYefv/1JuRxRB+smv9MA2PxnmUL2mw17TPcdrRNHomVybX?=
 =?us-ascii?Q?mkBBieCWyOv1jEa4gw00Yo40YKXXyQtBv50CU4ssRoACLtC6Q9GeDQCXhJRT?=
 =?us-ascii?Q?uJLfgM3C4WiYI94V411VcUNHh5QMTk3OdMrf3QeKl+uxEXuFyNz83dF0Eoa1?=
 =?us-ascii?Q?wjE0Hu2R+ifuCVR0XPqZtZSN31rvleJ62GVwe20Aw84PvjEtURPlIT8kTprB?=
 =?us-ascii?Q?NF7H3j/BYL69Kj6KiHvNgoYMimlP+OUXbm4jyHhgu0RKhsEYkn9tZ0kd6u8i?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21524116453F36468C96169018330754@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GeMaFlxn9pylYO56qo5L4zw1VEpHLGs9L230vIpNyB7+P8ykDhtkq6ON+xPowBwvJS9kFhhlPX9XKjz23I1GjxpfI6rU6kH0ItrE1x6QIi6yvVt34d2T0TEtISYFLsI47JrG2EY5Wr5bucbpZnn3IPo0j72Z5TcUPqnENQ2GmjYxGzZjjDP1B14O6PeSJNjCVZXswuJMhau4FUrMSfbCrX3uYcJWMiVrs4kgTp8cqTpCKBcin7of0AyrDEZBQhOThmyhon3XsjP3HNuBWxALsotKSaRCW4JoXpw8DhOaEernBFxndrWtUyVbPJ3Op5OgxzPwInzS210WIhD+ISso07QWDFUCDaAJKHUzFwodsbSF5OLrY77rFvwxXdZpBwiXzEZ9v8u1T7qT6MXhwrrwwQbqAvool4Apn9aTExbzoaiBA3/0Sj7rVgQwjIuBfwZ4GTJ7IbDVssE+d9ATPJQpViQt8B223OGnnAwZFNkuQanSifdRQmHhB06nbqxc4k84PINblOA4bj1rUn2k5TTfxdjylwLxG9RtnixGvnA7sYcs+4VmVvsGwtlyLKoRIxRuDbO1KKUHq6EEYta1Us0/LvROKYhQ364HVyDIl6nXROt3IPL1HvvHF64nlXeC9xuDF7kFeimZIy4x4s2SLxiNaaPEQwEWu0E5njjDMWO8MbX/wzaL6uIGYCDsgq/IRLKhGIjTdlBS7PgWJgXsoeUFoBeB2/HwIOM0PKLfUA40SGs/NXVYiJydtEngZ0LeglToYke9596AnaYXFKQmZaYKSB/S01R9IQFMnY+xjqOXHxZ9cVo0txu0hBo2nnasmuWSFn/aMaLiSAmw1fPAYeRM4w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fece572a-c16c-414d-4c9f-08db05f44f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 14:38:26.1993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POfpHo5Sbw+MXtqd0vu3gU7QWoXT7mXnMkmfI2xFICFQ+Gj+k/gOf/Sv8SuZw5SzHztUPHNT7dMlwblDTSVM5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5064
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_13,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=899 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030135
X-Proofpoint-GUID: O1GFd-lIVUcRXFXX4Vg8lG3cmvYQo7fH
X-Proofpoint-ORIG-GUID: O1GFd-lIVUcRXFXX4Vg8lG3cmvYQo7fH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 1, 2023, at 10:53 AM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> On 1 Feb 2023, at 9:10, Benjamin Coddington wrote:
>>=20
>> Working on a fix..
>=20
> .. actually, I have no idea how to fix this - if tmpfs is going to modify
> the position of its dentries, I can't think of a way for the client to lo=
op
> through getdents() and remove every file reliably.
>=20
> The patch you bisected into just makes this happen on directories with 18
> entries instead of 127 which can be verified by changing COUNT in the
> reproducer.
>=20
> As Trond pointed out in:
> https://lore.kernel.org/all/eb2a551096bb3537a9de7091d203e0cbff8dc6be.came=
l@hammerspace.com/
>=20
>    POSIX states very explicitly that if you're making changes to the
>    directory after the call to opendir() or rewinddir(), then the
>    behaviour w.r.t. whether that file appears in the readdir() call is
>    unspecified. See
>    https://pubs.opengroup.org/onlinepubs/9699919799/functions/readdir.htm=
l
>=20
> The issue here is not quite the same though, we unlink the first batch of
> entries, then do a second getdents(), which returns zero entries even tho=
ugh
> some still exist.  I don't think POSIX talks about this case directly.
>=20
> I guess the question now is if we need to drop the "ls -l" improvement
> because after it we are going to see this behavior on directories with >1=
7
> entiries instead of >127 entries.

I don't have any suggestions about how to fix your optimization.

Technically I think this counts as a regression; Thorsten seems
to agree with that opinion. It's late in the cycle, so it is
appropriate to consider reverting 85aa8ddc3818 and trying again
in v6.3 or v6.4.


> It should be possible to make tmpfs (and friends) generate reliable cooki=
es
> by doing something like hashing out the cursor->d_child into the cookie
> space.. (waving hands)

Sure, but what if there are non-Linux NFS-exported filesystems=20
that behave this way?


--
Chuck Lever



