Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05815602DD6
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 16:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiJROEb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 10:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiJROEK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 10:04:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC124D25A7
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 07:04:00 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IDxKOW028698;
        Tue, 18 Oct 2022 14:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=sp8F7bNQCnShQAZgVWHsunSUbgc01t50O5Q5Y1/V5rQ=;
 b=hMOq77TQlAeNC66GW2lMlucQX/ZbLPFi9BgZf3g5W8IFIhchhRJaC0I5kr5cUhZtuYyA
 ibmvPqB5Upxpc4/5DEeWvE+G8wyI6OUysQAqfaRj9q7dqu4IiXjcG9i7bE4Rf7rPI7D9
 bgoAQQG9oK0nSaBISWAdrrqZwxHvRjldL5aqXv4bAVYfaciWHNedBohDDxyGhO1qZDqd
 i/PY4F+ELakO81+qvJm42KAaZdkVUxhdXbz5CSWQ6R6ZWfadmpaNHquVFat6ZWMlTGO5
 JRHtwaVEi+mp4tzE4Jiumd3SeOJ3ncsU/Po2rDue8KtJCOjxFAV6V0YWcao4bWs7v2CD nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7sjdqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 14:03:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29ICe0ET035626;
        Tue, 18 Oct 2022 14:03:56 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu799ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 14:03:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHXo3cjhGWP9WrjFwFm9gjSmBTbJ+TCyb4lz2moWl3/ELtI5+DIwd/m7jICviNvcy94OvpBiBK6wCMBeZhN47apaCyAppBl2YQSnGU7rKabckiBbr2/r8xsQL+LOE0fydkUGqIMCXT0U4nCeIC63AYX9ekl5o5jU/2S0ep6fqElyQ9Xh5dXNN+HxULrjq7tqrw3CPuqmAbSwjP337yVXXJMa9UF1dCcB/qaG00jwXWuZFWLQHaMYkBMlE8wKY0/AVuk+bWCWYYATOSgGRB45WQY1eIAhWHPdCY8b3Z/Nf7i0YCdcZy45oNWVKdWQysl5Exu5H+oehGhYmWoWImqfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sp8F7bNQCnShQAZgVWHsunSUbgc01t50O5Q5Y1/V5rQ=;
 b=OGuHfdlCRGJVubEXsV1DCjoo+5ukrVrtDD3pCoXkAbMe9e4unO8GmoSfInJbnL2B48cChRO8j0hoAYDHmlFhHNByzvn++4CP2RKBviV3ypqyg+FGyhLhYdXZIVOZQSh74w7iET8vkBzXR1PFDlUuTPurxM2ZKkXlp46uzqn44aMfgtri35JxcE+DyTwvef7gkBXDkkJSSJoDfhxZNM/VfPU14wo+2nPc3kT3en+FWhv8Cty6M+PaAnAxAV4AvPNi0mFvCmLPwSW4JOr4EjJwg7A0FpDVvEIgH1msla6qDqgz9lHYvVd54XSu5xdP7XSGMFJIUvxBRO+Aju01Z9Wdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp8F7bNQCnShQAZgVWHsunSUbgc01t50O5Q5Y1/V5rQ=;
 b=QvQtQlMLxOy2PMDDgP1KDh+kUF7SqkKy2+UzdAQFuvl3NFxtSrsWZa0iy0wgb4Rmx0qCli91fxOI1tUX3Es0W7X4wN5cvhcIB0AiiYlVDL5RAL0YNggiqI6qC5y7lIyZBR8TYX+EE3TkvKEjK88X/xDPD8uVVU6PaNHdCPscowM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4881.namprd10.prod.outlook.com (2603:10b6:208:327::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 14:03:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%4]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 14:03:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>, Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] NFSD: add support for sending CB_RECALL_ANY
Thread-Topic: [PATCH 1/2] NFSD: add support for sending CB_RECALL_ANY
Thread-Index: AQHY4rCyP0zyxdQiA0K9SYyjH1DWYq4UJL8AgAAKxAA=
Date:   Tue, 18 Oct 2022 14:03:51 +0000
Message-ID: <AD39E6DC-F52D-49A0-8405-7ECB517B64BA@oracle.com>
References: <1666070139-18843-1-git-send-email-dai.ngo@oracle.com>
 <1666070139-18843-2-git-send-email-dai.ngo@oracle.com>
 <2b3d2faa-c430-b456-f7fb-25dd6273d71a@talpey.com>
In-Reply-To: <2b3d2faa-c430-b456-f7fb-25dd6273d71a@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4881:EE_
x-ms-office365-filtering-correlation-id: 1d674e8d-e92a-46b0-a2ab-08dab11195f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: onWhW9fq3tvtIxLQm+MQQQROVyT8FCqotudTDdScW7q3Ey+FJUCl3MjbliVAc2DPm1vWso/tF3igho3BEmZXC5dXqThrXkxACbY0L7+tVtTyD5BLKiRPDJMJatCQWt7aMs8Awt4BHE1xJR1PYQcy6sVDzt2A1xEaIJH7G5f1qZqYmalyOpiFe+o0xz+eHQ17U+KGkdc790j4OSKLT09O58BkAH7AxahSUlY2tnQMfwRpKgfg/YNGIKrkP1mdqL+D/OwmLBqL/ONAqT4uwrP5UYeI0zUK/PUo/70EK3Fnzfn7W1iHTTB0T5DFn/PtBGL7dSY/WAh2lwre0pvDc3bytgQ91kABBmbjSh0lw4w1h3RmITho/vUjYXzSkvSAmO6ScX+UhcMB2YaRUwK1y3CSwUi3kBIIHngeB8TfcKHZrCz4NU/66zA2OLA2jWNJmflqUzvizzZxGJOnyxR9tkRq0D+4/9fzHMDr0IpnpuR4z0Q2kGVB5wtW6/alv7WWY4X1qkcCJAQ2IkgSYk1/nufajgWlM9MfVEYrP93ZbsRuTP7cc9H9eQDOOPF5kvDHdjXhXe9pbtZrPmsm90CYqVqMFQeAWptH4SaapFOU4r2Jc7GoVYuDXeGPSMVVjUO1jpqfCw/TUXWOnhU3fc0MSB+q1Tc9+H56xRCost7Bm2MW7GQA91Q+rAfbzDGNTzDtovQk35TfBFQCKI8WRg9on7jjI8TDNd046acWIdTzTSIYRYXkBmc8D4OxBvpA1uuN3SYkBV8K/DmjHUxpA1aAbv623pzYAIybB7fnsmdKcuA/gAM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(122000001)(38100700002)(478600001)(86362001)(8936002)(5660300002)(2616005)(186003)(110136005)(38070700005)(71200400001)(4326008)(6486002)(91956017)(316002)(66476007)(66446008)(64756008)(8676002)(76116006)(66556008)(33656002)(66946007)(2906002)(53546011)(41300700001)(6512007)(26005)(6636002)(83380400001)(6506007)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YCh3Mo/Et6h9UWaXnlY0rRq4949s8nRDWA0tqwSaOduCRtfcfwSNahzxMW68?=
 =?us-ascii?Q?2nljOiNFkWb+bWjNkQ3I6R5WC11cYAHagOq7PzKktH0PMVnf6E6vaJaHzbbL?=
 =?us-ascii?Q?m0hRe/36nXXNkcqWk/MzpEJe+8HUO+nCZjrwrQxUp5D5CXsyy6Ky0zztRvWc?=
 =?us-ascii?Q?V9QkEwqz9sYmBRLauFQi1/jM9PIoukWvIo3tg3XXB6kfPm/flpvgBp1Nqe3l?=
 =?us-ascii?Q?9k6BPsv2RSWFVFvyY4kw+fmCr0hQ4RSA7sG1DnuzgifftM16QsfIMHohdKlW?=
 =?us-ascii?Q?A6zpEiROIegPXjhfyziKEbOB2hVrtK5DSyK4KG+c75kU4FXGruxjqqyZuG0I?=
 =?us-ascii?Q?jRtIpvo7qDAYiiijfChR3iOFoMED11TSXhmvM1sb+rQneKXZoHKxOUHwwJ1m?=
 =?us-ascii?Q?fanC0SDtTLmhAqua96LBUFOHDa/YW52ANSGZgHH6wGes6/IOhqqP+8v7YfG+?=
 =?us-ascii?Q?omNR9pvCg7b7KNgORSvaKLCzORrsTkaCjxzrFGUhplnfSW/rGoOLo3/CK5JT?=
 =?us-ascii?Q?kjcjk8pSFPPUrIi09C24viTAXAFDCc2uZFPJlvFkMwK5QWPRCpsdiv4n/P44?=
 =?us-ascii?Q?ycl4MGC3cwBjEu6zs+E1LdLHYdLOZSIqMTWetrkvU+pZvbOeK1hnpHgXcVt5?=
 =?us-ascii?Q?uv+1QaBSRm5IMuOszN4l8yAA0W3MhhyVn7kO5kP/E79jSjDuDQb60MGH6MbM?=
 =?us-ascii?Q?1zh6+yyEAoc1fbEIURcCIAZn/HpkzBz7oGGgseRikz9tXhNm21ThbThMk+Ji?=
 =?us-ascii?Q?m/v/4b6RB4VKB8zOXVHfOi0RQY3ZLhU17CAq1c6p0mzSyvALn+x+x8Y9rITr?=
 =?us-ascii?Q?rQbfEjhXGUOTSZWE3OzkKP8jJEl0A/BAWaG+gIAZOSSw/Q0k3ssNn1MeHuHe?=
 =?us-ascii?Q?Z5uCL6om5NNwb+i5RpJ0d3qP1RcvzQrmac/8RFm1vGg7kh9gsJizg1mnOUjy?=
 =?us-ascii?Q?hCGpyztlKGEy4ObnvRj6MXxe6Wl4C2GQPqkmAYuuYxHnuYOmpi3vzO7Dm43J?=
 =?us-ascii?Q?w8hCz/v56IUyBN4v+Vf7mpjV2//7VLSqX9rMo0rFeVd4zuM/vdBcdhqW5Cjg?=
 =?us-ascii?Q?e7y99PHArQyNknE9ZHK3+6byC+ezXTeMH5B7GYDSZ+aDPYl7IFJtm1CqqDK6?=
 =?us-ascii?Q?aSlmMY6fvdQVfdP8SF1XIs9/x2pNDJHbi5nFOS1CCqvo8nW7WN0dIRck4zwi?=
 =?us-ascii?Q?TTcZseugd1D6fnTuuvaCdu7sFTR3c3Jhd1AUs5Vha5QuspYjMDnN7SRQhB3E?=
 =?us-ascii?Q?5hO7U4PB05vQzv8XtgD5cGelrAupaSHjFWo+4rIU9z9BUQQXpxvYKWsw+fwF?=
 =?us-ascii?Q?RzckJZzyf+sz5cegOM9hxzf8kkxWOt9odeh0OrLJSawYsVhsdVIBW39i7PG3?=
 =?us-ascii?Q?tRVpGXKSV7pAk4u+NUELjj4VgSWxubRpQDh+EWyFBJ4c41QOYAew5l/9fv0F?=
 =?us-ascii?Q?nAKKPg6y78M+fRbpd0qJsLJih618igp+A+pwcBAbn0ErzyTOGJESHNgIpMUi?=
 =?us-ascii?Q?+5ys8eKrDzGrByY1eP/ZaQAbfAIe75Q6RW3Sh7vDlYPB12FZ2fX59CTFnS4o?=
 =?us-ascii?Q?gBzYwGXEByyAlp7+DxA+BNEAgrR2BofSPaWX3U/9VkyB0oBUoLiFWjt3vpD5?=
 =?us-ascii?Q?mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D5DCA6AFBCA832469ABA7DD13CB80BB8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d674e8d-e92a-46b0-a2ab-08dab11195f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 14:03:51.4472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bs6iT+ehxKFfUK4c7advzlvRfTsoctvcfCMhU5WTMcefW6d4B/wvjxlzlA2Azfvvq3qD02bYu80ZywRqipeUSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4881
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_04,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180080
X-Proofpoint-GUID: Av50NqurL5Vf9TxjsjQt95coIn3GUQ9v
X-Proofpoint-ORIG-GUID: Av50NqurL5Vf9TxjsjQt95coIn3GUQ9v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 18, 2022, at 9:25 AM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 10/18/2022 1:15 AM, Dai Ngo wrote:
>> There is only one nfsd4_callback, cl_recall_any, added for each
>> nfs4_client. Access to it must be serialized. For now it's done
>> by the cl_recall_any_busy flag since it's used only by the
>> delegation shrinker. If there is another consumer of CB_RECALL_ANY
>> then a spinlock must be used.
>=20
> I'm curious if clients have shown any quirks with the operation in
> your testing. If the (Linux) server hasn't ever been sending it,
> then I'd expect some possible issues/quirks in the client.

Is Linux NFSD the first implementation of CB_RECALL_ANY? If other
servers already have this capability, I would expect clients to
work adequately.

Of course, if the community doesn't have any unit tests for
CB_RECALL_ANY... "what's not tested is broken" -- Brian Wong.


> For example, do they really start handing back a significant number
> of useful delegations? Enough to satisfy the server's need without
> going to specific resource-based recalls?

I don't think of CB_RECALL_ANY as heroic, it's more of a hint. So
if a client doesn't return anything, that's not really a problem --
NFSD is not relying on it, and it certainly does take some time
before server-side state resources are eventually released.

Another possible use case is for the server to start sending
CB_RECALL_ANY when a client hits the max per-client delegation
limit.


--
Chuck Lever



