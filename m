Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3CF6A99BB
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Mar 2023 15:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCCOmN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Mar 2023 09:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjCCOmL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Mar 2023 09:42:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CA14C6EC
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 06:42:04 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323EdpM5003520;
        Fri, 3 Mar 2023 14:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=n+us5DrYTH0X0xcYEPK+DPurA0LzjQ3IugXOo/4V6ag=;
 b=em3yIQIPsl2NLeGK3q1mntGbsge6p0+Ny0hP6bRqNrU1gXXlwrT6tgudpGCycCu19Z8Z
 PuR0Lt9XjDdehBZMt8q7l1jBCC4MlttqP/zfRWRygeTUOxkfwcZeIqLKUUHrh/Igcmih
 BBvS0YB7IAC6x2kS6fixf7eH/+fUDKl0RkRyR4MVBJY+d+PzmueqE0XpLqyfpm5y7j0n
 ypIufwoD93o4FXn8Fnv91WbKcN4dGOFr+v8FET8fx3R+jlm9HFZz8j7gbN69hKU39iKc
 l+w+56F3x5G87gCIX+vc5/yzI+xh27b6C3JYLttcZjnMWGmo+btGV4oU+46ogdMyYWB/ 2A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72p9tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 14:41:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 323ETFRo002332;
        Fri, 3 Mar 2023 14:41:55 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sba4rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 14:41:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZ5C6DYuUDlKYpQJqOniMV6KoU6t6mM/3JCN/Y0C4AQFZMFZh9xQjLXkVIQnHjfjIh16PMBxD1EX8oig+sb0UB8U2h8WZzawErJFysyOBH+wtcr2KfEUCAe6i2gglZzNlJY3nqAWRhyvJbP+F1U09cIn2DB95U7cQsPU0vKCN2XTObUMDCRWnn4WB9laxTNaK+KFNhRSSGWkvrg+Zxs4g6fYoeSWV4jtEwnfGDvpnjcqaUOSMDr3GMBKatj9H9VBp5nUhtVnDS2tkvu7Enn5OksyVH5c+dUqFJiHs++rPFlGwAK/atjaFh6VhB5RVJ/9cFUZooRLm9QOL8DpRm6hWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+us5DrYTH0X0xcYEPK+DPurA0LzjQ3IugXOo/4V6ag=;
 b=kKlr0gc8BpVjEEHj+Vh8oomLDtS2UIANTf0XWV0DOe+IfO5/bqZa4GRe9kA2r2m2rjp1Wf2Bn6TT/o2wXjsLzHOJdliEJlqoih4AHYpqLw1w/YLf/IEShL2oJZGsrcmucbPtMasHT7Sd0LqUeAYxA9Xh9V9TVQxLfUHxjpZR+gE+9vYtVKwQhDwjvAQJnz7bRb+g0diLKRNi6+P/pYi8IyK78qE2PfIwp8eXGoMMeuwY1NGpv7jnR4xcowP8i1MdefOY8B/taNJyGPTbljjBrFphA6TOpnV/+VcIvIVrPxuvk2OFRZRWe04BROJ1cu5sBVknqil3Bzspzzp+IfYIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+us5DrYTH0X0xcYEPK+DPurA0LzjQ3IugXOo/4V6ag=;
 b=KqNwCT1+qTz9mWdOgjBh0Xl60fyWRKIeZqAwNlEJk9MLzYgfrEY0ccCypt5BQxSa1+J+weR2ZRFCr6feCEXszdmM1FSIDx/vRzonOMK/Dipl4dE3aTjm+GH8MYOsHMxQUrm9liiibXKN9FRVVTlCz/dE2vdW8Y2ar+oSk7CwTs4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6801.namprd10.prod.outlook.com (2603:10b6:930:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 14:41:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6156.022; Fri, 3 Mar 2023
 14:41:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "yoyang@redhat.com" <yoyang@redhat.com>
Subject: Re: [PATCH 0/7] lockd: fix races that can result in stuck filelocks
Thread-Topic: [PATCH 0/7] lockd: fix races that can result in stuck filelocks
Thread-Index: AQHZTcnxbdBJ4h9EiE6itgxSR0amOa7pIQIA
Date:   Fri, 3 Mar 2023 14:41:53 +0000
Message-ID: <0FC66364-4F59-4590-9211-EB54E918C97D@oracle.com>
References: <20230303121603.132103-1-jlayton@kernel.org>
In-Reply-To: <20230303121603.132103-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6801:EE_
x-ms-office365-filtering-correlation-id: 1d624fd0-1c57-4ed4-e104-08db1bf56e44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nGX5375zoWjsXclCuvEre8NEanWLrbDJcv+XRindOcbRIZl1vYyiIYgTXVKIfLzx47MkfnlQqhlGxZYJXZFAfODiX+PDasJhND8TlqxON8GJzoUHnGh91YaSOJQsYfKkL/LHXlHd/JkbHKXhpjA27gkvq80eq7lEMIqHI7cFQoKURPKXKY+vhQ/pOzgGiNc802HEbNERt/9MFvw2EOL2RyZP0qNxa33DeACVX3Q0DVUdhEptJaUwJke30P61u0aOeCi/+aSe7DqWrGqNiyEqE7t/KIVkbvFl066TyUwq35BHdVVxmhpfzWbxTWFYKegnIhtI5p43H5ya/8KKhfFPuGoslOF95oHxEcM3iC54P2m5jGBRkH9CDIHHDKdcmV15MW0/k+3d/RFTNK1Qf52chzB4yNVFEFabT9icLplu/XCUi6ZMA2IoIpO4Ip+QUMrxQoMq6JcDXNSNw78T+aWE5jjGv3E7FI57g7bwyLTsS/+EaQ6/bKHCXpk/gp40p+FZD+KihJT10t1l4SPxGusGA00NdwO3C3Y7hnoiAOz7XOssb71xADJZp3mDaO/lwCxeIhW/83/j/r8zM8LXwnt2mRYDyv3QnB1Ugprn9VZVPFVu4+2W8YAuWsC//HjcXIzKMrLZ48TlmKZK2vlE2Eaav4mqx74WP4BZ9K8WleAXBeDXljGHESTSNjGc86lHvR/JWmHqh2bm/XbgRLRKsZbmVCcm4oEPGd5NBAN8hUc2ksE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199018)(36756003)(33656002)(86362001)(41300700001)(66476007)(66556008)(64756008)(66446008)(6916009)(8676002)(5660300002)(8936002)(2906002)(4326008)(38100700002)(38070700005)(122000001)(6486002)(71200400001)(76116006)(316002)(91956017)(6506007)(66946007)(478600001)(53546011)(54906003)(26005)(2616005)(186003)(6512007)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E84ivP77qDEJ1RLI1FtWLGJHfHz+PDQ8SWGPpOemLTqjjrxkdkUSdwAkAxWe?=
 =?us-ascii?Q?aKjk5825+L7jO9KNTSzudCzJGGUP2UC0lbzfe6TGdHnIDllLTOsojNDos2Hh?=
 =?us-ascii?Q?IO8i50B3i9dvDDBIintXKK0twJr8AUeDY5QNO9k5FWE1m0C+97QAo0K+ihUq?=
 =?us-ascii?Q?qtSHi4Ze79m9X8db4tCan0aBvHxtMqWEOv98k60hrQi+VpsDbYC+ekwizkHX?=
 =?us-ascii?Q?qqaYPF2d8x6AsSl8mS7ESQ01PawfSr80t58MNhQX6PJcD8MJGQKAsNkOjErH?=
 =?us-ascii?Q?JA6YGFuk+7+XbZcicHQ9vy/sKdCO4dr7Qim/Gpf3OYkqTuii+9LFVkHiNGfs?=
 =?us-ascii?Q?uhBn46jG1gwRgHKLSnManaiEhElaf+PG6BKIBBk0dc1Lxli86b+PH+uaCgpX?=
 =?us-ascii?Q?K6K/acoYgcsrAKQhdqRuTg24l9tK+Jrv9YY73K4Al7VSzwt/Z0Ddup2aSf4h?=
 =?us-ascii?Q?jwq9opt7INmzx4RX+l5BqI+EEBiP64F9PzyLDrZbAhKeNcNTkYORTS78n3/r?=
 =?us-ascii?Q?cBZ1BTqXv7hKJKSOqwXJK+SDHufayS6Bvttt3sMhfCboyD0Mauh37tyrVPbb?=
 =?us-ascii?Q?F0Qzwc/0HfjOTuFmxJ7hZkPs4mUs/GlQ1sK3amPv4038oggoKyOp5c0vkDf9?=
 =?us-ascii?Q?YvfvJom9BP/iwCyWROxvCRzOo5eQF2Mfu8VvRk3IoGTCLH1jjta83SzCL6Vb?=
 =?us-ascii?Q?srZN9Gg0covgIO01g1aUMZjIuHvcr1vrmEX8SoKgo4rPopOB7nLhC7x07Z8q?=
 =?us-ascii?Q?wUXB+nIZ+J5iPXY83WwVs1Fo6i0whL7DT/QOtvFrY3at47wEuMaKYT1BDNPK?=
 =?us-ascii?Q?HsdXPbn19iKl1oDqxPm6ej6bcBBfBao+RFNWtMePaFWsFbiK12Ufh9LsEL7m?=
 =?us-ascii?Q?TC94nCZ616aQ9Ol52Xb1s9mnk2w71zuiFSzswf4A/tL16/KfU4EgF5SLNNlI?=
 =?us-ascii?Q?AfRmBTUUOd16jpFqttAIV9j9uRjyJn/olZdAfZ6nsehJWbv+oGQWbTxGgUDp?=
 =?us-ascii?Q?7NP2JLiCtAHQsnXqR2X3U06PZhh6tEA0Iu/Z9RCk+f1uo85y41floce4uut6?=
 =?us-ascii?Q?cJxC5Hy/FE07ksDYzjF5hMfWDHBMH/FQ8Tip3+USPBaklaJmTRiEWLsm1ShK?=
 =?us-ascii?Q?zaiQ/f9jbOE/3Ef/HC0w/J782v5bNoyOlvUIor/egMO0IdCektVuc26BQGAe?=
 =?us-ascii?Q?8GPtJ6IuVFmsstclKIgkbdrqgR6JBZYmDXtzt7sTnCVDv7GCnyO08i0Ou4jQ?=
 =?us-ascii?Q?BX28iY5TJ/UvehMYHbdXxYJJKjNS36gBtUc8uWUg1cvvEFewmVKpIQRpExdg?=
 =?us-ascii?Q?XwLFy6vHXf2Ur00ztvqhJhrl1QmM7BhwibnxHllo5Yd2eDiyfE0f4e083UPO?=
 =?us-ascii?Q?fEuEJmOCBTn1VP0CT6YC37Xegbxd/nBUzXhQUpx4oYMM7sT5TWYUijBq7xac?=
 =?us-ascii?Q?hb1fASEkkWfSXxmU/9lX57yPdnakfE1yw7cZ+6jNA/9uEySUpioUPal+TYUp?=
 =?us-ascii?Q?DFc/QyaGd5ePzvylvOHtCaXVIBGveg0R+u2myRprCavEfphX/y+sA+A+z0/9?=
 =?us-ascii?Q?sO6QYtWuxjWdqYtYholg2q+gKuuGsC+a+G4zdl5/KLfx9upesIH4nfufdVs0?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC950AC37A7DAA4CA0391AAB6B121C9A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zIk7KDBtj9FYwV1IEVNP0Ry6aHcP0WdO9wbf/Nn1LsJMXmLO/gubCBafevIPbM0A6B0yZCMeO6QD6sjiek148F2bY02zDiTwO/SV3t2CbncECu745UpiaqvC+uihfjqGY2XFMoC7jTcmMXJst3DhcBXp+0HAVaG0Tu+O1hu242/tXznYdf/XEFMiT+FhVqQdJ3StX9GoBaTPWQNrstIouETVaMma//dUb98WMae/7y2MFkop66vtsvDTjX63VUfcB0B9JWo95T8K/2JlOVc1C/0SNUp3x5kC2KdOF08+LLtSofyciU0JDcTOUIkLr5TrEq+3RUnsRfgd2+8vNBFYMlVwbAsBUULXtrjrqcgqnRxMQnrxK0JP5aRMB7EotXPv1aVRCaJMQ/a6XCYphkurrIFmohAyk1qqBuwJBXrU9bDNgS/cuAKV+Mz2Kmt087SRSDEPsYtaJvkR/vRAGInpUU4TykdwdlR9u+mQGeXQ019j4e4V1+5VTgrzQYRJfUOaWGn0FVSZaUyWHngsnokdiR1DdxPnJX1YNqe0fSuLuA3HwGgHePOeL/NXaD2rbHJUQiWRwbo+oyet3arLKwlMmBUAJrp9kBwKCFF5tanP7hIXO0Z31JWbnXAKC4JAnnt9MKVwUfgkOakk2rreEmasNQVhoPuvmc4lObWkXHlU8hY/XqBu8ErdY3wcBjHilpc5IJxCKyLM3cFT5GNhgUrNY/AYhKdxt2S8g5mtShgBJem3UXoHRJIHlr0uu2Y/AU0bxtsn8j2vIE2Vle8g7F1OCd4foEA3rMCjgyPH2xrc6f9zzAJiw/A7mfU6bdE9sbXVx+DIKzmIZG6IG6DKK4Vv8oRsi1f39u7j+ipkzMn8PCU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d624fd0-1c57-4ed4-e104-08db1bf56e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 14:41:53.3377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXJwhTTv5FPJekjG+23PRX6xOh07qR+qY5qd/WWHafDV14JO8O8AZLj8P4YUsWVuCo/xYMNb8kfmIbaqhWvMRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030127
X-Proofpoint-ORIG-GUID: ATheqDkrYxxhMwhO6SylgRrn-5js2YX6
X-Proofpoint-GUID: ATheqDkrYxxhMwhO6SylgRrn-5js2YX6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 3, 2023, at 7:15 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> I sent the first patch in this series the other day, but didn't get any
> responses.

We'll have to work out who will take which patches in this set.
Once fully reviewed, I can take the set if the client maintainers
send Acks for 2-4 and 6-7.

nfsd-next for v6.4 is not yet open. I can work on setting that up
today.


> Since then I've had time to follow up on the client-side part
> of this problem, which eventually also pointed out yet another bug on
> the server side. There are also a couple of cleanup patches in here too,
> and a patch to add some tracepoints that I found useful while diagnosing
> this.
>=20
> With this set on both client and server, I'm now able to run Yongcheng's
> test for an hour straight with no stuck locks.
>=20
> Jeff Layton (7):
>  lockd: purge resources held on behalf of nlm clients when shutting
>    down
>  lockd: remove 2 unused helper functions
>  lockd: move struct nlm_wait to lockd.h
>  lockd: fix races in client GRANTED_MSG wait logic
>  lockd: server should unlock lock if client rejects the grant
>  nfs: move nfs_fhandle_hash to common include file
>  lockd: add some client-side tracepoints
>=20
> fs/lockd/Makefile           |  6 ++-
> fs/lockd/clntlock.c         | 58 +++++++++++---------------
> fs/lockd/clntproc.c         | 42 ++++++++++++++-----
> fs/lockd/host.c             |  1 +
> fs/lockd/svclock.c          | 21 ++++++++--
> fs/lockd/trace.c            |  3 ++
> fs/lockd/trace.h            | 83 +++++++++++++++++++++++++++++++++++++
> fs/nfs/internal.h           | 15 -------
> include/linux/lockd/lockd.h | 29 ++++++-------
> include/linux/nfs.h         | 20 +++++++++
> 10 files changed, 200 insertions(+), 78 deletions(-)
> create mode 100644 fs/lockd/trace.c
> create mode 100644 fs/lockd/trace.h
>=20
> --=20
> 2.39.2
>=20

--
Chuck Lever


