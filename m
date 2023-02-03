Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B6868A11E
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Feb 2023 19:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjBCSDc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Feb 2023 13:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBCSDb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Feb 2023 13:03:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107258FB4E
        for <linux-nfs@vger.kernel.org>; Fri,  3 Feb 2023 10:03:28 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313HmkWl023913;
        Fri, 3 Feb 2023 18:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LF4EvNLHxU6MLDSg6P+HtItNr4srXzKFbM8h+tntSdE=;
 b=REm/DwM1JAJNNlHPdkvoaK3q65zDgM4jgqt2/7UeCh51XIMFFwTGk27coiDoPzOUHlRg
 PGfozzIR/736yQuynXe7kqeyA2VzwfAbqcyqOGEGLnNLaVUWoahZGU2sGvVfs7lV5M2V
 P408rOA+vJgvZIz2GWpC7K37GNizTr05eZ0cycctV+43827uCH0ktglwxzuxMHzxvlAv
 ZUd8EijayQ2DmlGbgGvFBS4OQtHnoI/L8M1KxsApaolQqWkgvEhNNiYuJv9ax6rVPB0a
 WHbY/frZQxrL+/NsBlO2Pb2aMhLXnkw70S4xh6PupnvOrwAtPo6zPc+7oYdPO905TPXd Wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfmbg6c69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 18:03:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 313HLU56005012;
        Fri, 3 Feb 2023 18:03:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5j001m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 18:03:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRo6MnuwG9o5vJY9aGtr4D/krSTsmq70Xxiy7Ge49avMlg8WUHYHAxMd9e4NtxR2vaJ+DdGb6oi/J8Sa31tlGXaslONZVFsEo2EopwHDPHAeQHLP0kL1TNM94xlkmOUI+bYO7Fk9zjPyNxyFaXX658syCnIJc/GQQUXjcpzZ9GXqAnJH+89w43+PHgfAWRAX+xqgPUjvD3SNjxrifH90JlWcDyMSFgnOFFM4H+5aiwKYpmCyfMniBIF5n7rmgRH3MtIM72Dt2kKjilm1gRxrCS9GlxzickuETf7LsuKEw28EmiFiX7ttpOnHfI1FdESf7G60iSibxLJuOG5Yh21TtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LF4EvNLHxU6MLDSg6P+HtItNr4srXzKFbM8h+tntSdE=;
 b=WP54Qr+5H5qv4Y62UkAbuGbKn/QNusVkgz0BhKWeHCtcpkuRBP/acJswKjRbgrlhssXY9X5tvdDbnDGhM++tNAbr+Gm1RNvHvTj5cOKgLrY9WlvtrGeBJWB9TVYHcMViV0JEQSZUOrOvXx6vbXbVy7uRNqkYLL9JJ6nt8+LjuP2h5l07TuOedtJ+8Jg81Dri0XZjY/JlU66upLLESqzWEdFRce4x9GwFFM0NnV4foVwoa9TgmzSTTr6f2jQkxqFtFgAvN2dDfcd0IzGNY/g8a60sHn5Q1ZyB6+pvSMDz1o+96pt5/84KOG/HWjeN96HcCfRsDt6vYcRHoH5pMHuIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF4EvNLHxU6MLDSg6P+HtItNr4srXzKFbM8h+tntSdE=;
 b=r60TemRTA87FGj7ziGECjRgxiiUvqZFY+QnLelel9yLnLEHEPpaGJjsxB1CoYGwLEAvyxjcLwnj0PmyR5yOTC57VMSWQ15g3F8yWD0A/3Pab2wp27pg7eZ05JMfxKhKhtH95l1PbRHjSIrb3CZVCO3XmXTQK3bdUi0Z4I0KeeX8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6028.namprd10.prod.outlook.com (2603:10b6:208:388::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.21; Fri, 3 Feb
 2023 18:03:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%4]) with mapi id 15.20.6086.007; Fri, 3 Feb 2023
 18:03:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: Re: git regression failures with v6.2-rc NFS client
Thread-Topic: git regression failures with v6.2-rc NFS client
Thread-Index: AQHZNbksRLoeBCG00EyL+s5Kt9KD6665E+wAgAEOhICAABzOgIADD6eAgAAJrwCAAAZBgIAAG46AgAANvAA=
Date:   Fri, 3 Feb 2023 18:03:14 +0000
Message-ID: <79261B77-35D0-4E36-AA29-C7BF9FB734CC@oracle.com>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
 <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
 <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com>
 <F1833EA0-263F-46DF-8001-747A871E5757@redhat.com>
 <B90C62F2-1D3A-40E0-8E33-8C349C6FFD3D@oracle.com>
 <44CB1E86-60E0-4CF0-9FD4-BB7E446542B7@redhat.com>
 <1AAC6854-2591-4B21-952A-BC58180B4091@oracle.com>
 <41813D21-95C8-44E3-BB97-1E9C03CE7FE5@redhat.com>
In-Reply-To: <41813D21-95C8-44E3-BB97-1E9C03CE7FE5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6028:EE_
x-ms-office365-filtering-correlation-id: 66297e97-b1df-4362-3e49-08db0610eba8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4N+uZ8guRSieggULWwM6JfRJuUbdMw+98WLJq7SZpp7jYq/YmUbfMKG9yaMVVo7OGj4Hp1MU1B/cBBneNPPJjuFEYf1iY2M86Qb4vDDH+SoblupOrgaLpXLQA4D1fGToznzgSrJgYMqFK92WAh5x4sP3bWe00gujAu/sNktChtOLg8IrIALzuNwT47Sdlw7zqMgUXjqr7jWay5wink4U4fjIOXh2dAko7tqckiWKL/YKFXFHWd1EdWOFGzvPKbgxw0aGsjrpzsXRKRrln8FNnvPsxc48lEmYMG1DozpP0VseGZvzmywe6cRX4FfxlywfRS4goRDLkA+T+0t3t5DPdumfVWtViV5SeBQu+LgFnnp7QThZDP55nW+4bJP6izLX8coIxaZM0LGJmRUJ3d6cAdmhY3lOTuL5oaouJebYr7UlsDeTzV9STMHcgAlZEAnhiFnSPjX9epvPjs9/JBzMyiJ3qVPCTZAODCV9+aeQrM3drNV2jN7UW51QkS6zy4/kDBG6dHuw8elk4FbHJKzJu1Kmg34WnM1rjprIgPTN5hq6U5p/QwvBuknfu2Tv/fFAo3aMgn4KU9wfQTtFiKV2gC7a9MNzOU+WgT1QPna8xHM9zbRfNgNf2RrLW2Rc2Yz0L9iyPBi34nkzqKwCospm5nce7mYKWR4/Yf+PEBd3CxxE/2aQN0qXvbQ47rgG7/jdEj9cgIyHhrnPniG2gCW7Mr8DksvwVTQZ72LRP1ZOdaGNGEndDYnTN45UwAH0GBTpMQj0y+5a/ikkVd+gpaUgHlq1nHy2LoqOXNY6XVHTduIQmXUg5dXOPYDCA6xnvP2K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199018)(83380400001)(86362001)(122000001)(38070700005)(36756003)(38100700002)(33656002)(66556008)(71200400001)(2906002)(91956017)(66899018)(8936002)(64756008)(5660300002)(54906003)(316002)(76116006)(41300700001)(8676002)(66946007)(66476007)(186003)(6916009)(966005)(6486002)(478600001)(2616005)(4326008)(53546011)(26005)(6506007)(6512007)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hZs8+b4QqmXf+nhozJBQgnf0jgHlKL77JeVQlkRKNjcTHhsxSiH/faiCVHMM?=
 =?us-ascii?Q?6JdM7fFKCNRIFwDz4rnUWSly4dWwDQ8nUqFqQrfnUuDsBhxd7z4iJMVw3gYZ?=
 =?us-ascii?Q?DhxOh1Qs9DGcHcTNxP6CO3Gmnm5N4Lht7w+MvEhv0yjZXCGj2D27Rtc55fJ9?=
 =?us-ascii?Q?QUjco1pMhHmHBH345HHkDYsxXNn4Bsh1n2D/bt5Di8kC4F4/HZFBAqPX4/06?=
 =?us-ascii?Q?mq0Yg1nvPo0kn96TCiOtj4/FnP9Je4YmMT1M3/9MZdT6/Pm/OpKtOUxP4KQz?=
 =?us-ascii?Q?zuwNX9J/g+FfBmWSrBJAFjUGl6XAaWTJC9DnrB5MDERzATnh+ZfmW0t1/gbH?=
 =?us-ascii?Q?OXVX9KRy7A5BB4CC7QbeiSVK42HZUaj77tBoIKpV+LRWf38w8nNVCxGJRDOl?=
 =?us-ascii?Q?yENQ17C99Fd/eM76SLe0D1ub4LZPNV2SRRnZ9I3mxXt2/zRNyT4yBSnjHB7I?=
 =?us-ascii?Q?eYN9p+1+wMlbOVWnHRa+ouwvZF8Ei6LAI5zLjMstt7FumNEM51Yzm2UNUS/3?=
 =?us-ascii?Q?s8K/thVqQGI5BBt7X78wFT/W81Bx+itpyNDQ9GxQIuKQOZKlY8iq+yDSEJnN?=
 =?us-ascii?Q?cuBLjCwPa3A8eF5WGMktTOk/vBv7+Hp6UsRpCy8FI790Ix7a+8N7+QZ0wpXv?=
 =?us-ascii?Q?QR3GakzydBgtOsglt+dLOZ0erN//YC+XUpetNf9dBxpZyWjNxDFxvbMw31zn?=
 =?us-ascii?Q?gt+3lakSsTE7amSYk8HRT+DGVuSajs10UCmsB1lH+2PwB41A+xcydw+ZH0jr?=
 =?us-ascii?Q?WljfIct38FagZIb0b9caPOPkApOemYD2E8sAqvwy/wQK2U5eEyE8eAdxWPyc?=
 =?us-ascii?Q?HMAMaQSJsL+aT8ZKgYUHdxjS4VvhHKywqy99CfE3WQaDn0iZw0JRqbQ0skpv?=
 =?us-ascii?Q?/VWVfnwW4mRq/e/BFbANSCEWyZ5FRnALHQv6fChX+KIa2pWEGJFPeMf/yUWo?=
 =?us-ascii?Q?kAwrAjH7k7u4Gpchu8hl9JROOmXM/QNYw4DUxIE9wK6K97DtTfPoiazo2I67?=
 =?us-ascii?Q?uhZEJFUG740LejjvOcri1rMFz5vAJ1LPOIC2YFrufKoUkJb6JbClv4v4cAIo?=
 =?us-ascii?Q?sECDmndrnn5EiX4VJIQJUoa6S2cD18f7aQLllVqrC9mDiLKOJaV25sjvMbPX?=
 =?us-ascii?Q?TfnoSvXmnvRCMSL70iOfPCypqn+9setJ8OwnYcGDCHY33LSSPwByq8CfOsbJ?=
 =?us-ascii?Q?rHERpVpfN77eIjSguRTElmLKFsTTX9QDkgjwrOeJj+o0H9XDmYFvn6Hm6drX?=
 =?us-ascii?Q?s6ed3n0NZUiX+P93HyRGYMVuSrAQ0JxK9I1HYRZ10elCeVisMjO0ou6HS34R?=
 =?us-ascii?Q?YP2msPKTjmro0NUSJpZIriHbQjY5cIG2l4iY1KBEcjtQOFDLogHdLt+t6boz?=
 =?us-ascii?Q?zep7oPn+86elVAAIB3JRNPokwq9n0cLc6wVwz3Ei2pDJaH6bX73A8xUSB+hk?=
 =?us-ascii?Q?MIGq+U1Q5g00x0YLawq9LVxYEqho8/FANvB/710jc+c2/n2nMCvbTbYrzGaY?=
 =?us-ascii?Q?TGOwJLl002yueKe/nXsRHaw83gK9oFOcO9A0aIRGq5ufT2yvCSp4zpCRYIqZ?=
 =?us-ascii?Q?GyfYn/hXv92ag0MUMWCG+O3Zo8f/zeApBNpiMfELshCpQaFBzrfdI5YB3SRg?=
 =?us-ascii?Q?PQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8201A11E7F9C694D9BF1D812EB58D36E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CdxMZKLEcobbTzyn27vAEZWHhI0mZYzsADBRXDDsWACKHbftelokXUOOpVUBkdfvvLWrp09qmzWugQBTHR2N89aTmjdu0BzO8KgwFNlant8GhArhToaBhu8nMIdlpA6Rh2R0tNYS/6a6arRvYYxnmNJa1at75PKw6+SQGWBDQeelI8aLwXxBlBqaG0o+40Uo1aebDFuDjt6/hovjy+k7V6DfldwfqjDxVSy0OPOHGg6mllqE3QLfkIq1H8nkN+4a9CzWPov96lICgKkB4tEHxh0sGrMphTQFkZXqWyJt5xIeD6RaWzWGj4SbzAghz29ST8akGrnVdPDB98aXOhvEgD3sKawPcXPjhaJ7XPbtaL0hnTfYqVxf0LLO1FWSVSpmB2Z3blOKoiq0njp3M5jeO5q6WDldYCtY5wzuhcTasduYZfMB1+KbTVAyz6MCnMKAnoYAFNjlWANQxjSaauFxSK+RKXpHj0074NCpDN2oTbmL1ort+LflUU2rX3CzaFhbJaKYWmmaGbIJSMwlwvxdZRbYpJ1ZgeF5XPzkPUhl7zYboVBzcOFVFbEn3aOTG8lNPIuUjeFp8nxzurUczYccbJjysTmegCjvse8pX2cu1bHoKKwM01mznFs2KDsuzwQp/WkxxDmQ+kEIDactEGbeLyGLiJFxTyDglHjoa/bTF4UNn/bVWpYVEphYIhb4zgVFQ+rf8kwyAJKWedFL45UXajlYEPhQRxvh+K7m4fRQFucxDpT2pw1zbJOzxRCxRIfL1qaZ1Q8svuIHs7FZlFhf85D4g5HPc4su/bmnFDlGac+9tjp+yad8E7Sq+O5EhNy0mgUfpSGezawBGOP2SLnseg6Igmx9j7MgDUVZjZL9KVU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66297e97-b1df-4362-3e49-08db0610eba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 18:03:14.5503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLYl8/hbGGLKON+vkGgc+6l29PCmCBVQ5k8yPG3D45Ai6MuUqQPmUwLVv0hdJyF6SJy9xbDoiiKPlRVdI3egtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_17,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030165
X-Proofpoint-ORIG-GUID: lWsYOmOZ69N6O9eVeJqQrvxjL6JO9fTl
X-Proofpoint-GUID: lWsYOmOZ69N6O9eVeJqQrvxjL6JO9fTl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 3, 2023, at 12:14 PM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> On 3 Feb 2023, at 10:35, Chuck Lever III wrote:
>=20
>>> On Feb 3, 2023, at 10:13 AM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>>>=20
>>> On 3 Feb 2023, at 9:38, Chuck Lever III wrote:
>>>=20
>>>>> On Feb 1, 2023, at 10:53 AM, Benjamin Coddington <bcodding@redhat.com=
> wrote:
>>>>>=20
>>>>> On 1 Feb 2023, at 9:10, Benjamin Coddington wrote:
>>>>>>=20
>>>>>> Working on a fix..
>>>>>=20
>>>>> .. actually, I have no idea how to fix this - if tmpfs is going to mo=
dify
>>>>> the position of its dentries, I can't think of a way for the client t=
o loop
>>>>> through getdents() and remove every file reliably.
>>>>>=20
>>>>> The patch you bisected into just makes this happen on directories wit=
h 18
>>>>> entries instead of 127 which can be verified by changing COUNT in the
>>>>> reproducer.
>>>>>=20
>>>>> As Trond pointed out in:
>>>>> https://lore.kernel.org/all/eb2a551096bb3537a9de7091d203e0cbff8dc6be.=
camel@hammerspace.com/
>>>>>=20
>>>>>  POSIX states very explicitly that if you're making changes to the
>>>>>  directory after the call to opendir() or rewinddir(), then the
>>>>>  behaviour w.r.t. whether that file appears in the readdir() call is
>>>>>  unspecified. See
>>>>>  https://pubs.opengroup.org/onlinepubs/9699919799/functions/readdir.h=
tml
>>>>>=20
>>>>> The issue here is not quite the same though, we unlink the first batc=
h of
>>>>> entries, then do a second getdents(), which returns zero entries even=
 though
>>>>> some still exist.  I don't think POSIX talks about this case directly=
.
>>>>>=20
>>>>> I guess the question now is if we need to drop the "ls -l" improvemen=
t
>>>>> because after it we are going to see this behavior on directories wit=
h >17
>>>>> entiries instead of >127 entries.
>>>>=20
>>>> I don't have any suggestions about how to fix your optimization.
>>>=20
>>> I wasn't trying to fix it.  I was trying to fix your testing setup.
>>>=20
>>>> Technically I think this counts as a regression; Thorsten seems
>>>> to agree with that opinion. It's late in the cycle, so it is
>>>> appropriate to consider reverting 85aa8ddc3818 and trying again
>>>> in v6.3 or v6.4.
>>>=20
>>> Thorsten's bot is just scraping your regression report email, I doubt
>>> they've carefully read this thread.
>>>=20
>>>>> It should be possible to make tmpfs (and friends) generate reliable c=
ookies
>>>>> by doing something like hashing out the cursor->d_child into the cook=
ie
>>>>> space.. (waving hands)
>>>>=20
>>>> Sure, but what if there are non-Linux NFS-exported filesystems
>>>> that behave this way?
>>>=20
>>> Then they would display this same behavior, and claiming it is a server=
 bug
>>> might be defensible position.
>>=20
>> It's a server bug if we can cite something (perhaps less confusing
>> and more on-point than the POSIX specification) that says READDIR
>> cookies aren't supposed to behave this way. I bet the tmpfs folks
>> are going to want to see that kind of mandate before allowing a
>> code change.
>=20
> I don't have other stuff to cite for you.

It's not for me. tmpfs folks might need to understand what
a proposed fix will need to do.


> All I have is POSIX, and the many
> discussions we've had on the linux-nfs list in the past.

I'm simply encouraging you to assemble a few of the most
salient such discussions as you approach the tmpfs folks
to address this issue.


>> I'm wondering if you can trigger the same behavior when running
>> directly on tmpfs?
>=20
> Not in the same way, because libfs keeps a cursor in the open directory
> context, but knfsd has to do a seekdir between replies to READDIR.  So, i=
f
> you do what the git test is doing locally, it works locally.
>=20
> The git test is doing:
>=20
> opendir
> while (getdents)
>    unlink(dentries)
> close dir
> rmdir <- ENOTEMPTY on NFS
>=20
> If you have NFS in the middle of that, knfsd tries to do a seekdir to a
> position (the cookie/offset sent in the /last/ READDIR results).  In that
> case, yes - tmpfs would display the same behavior, but locally to tmpfs t=
hat
> looks like:
>=20
> opendir
> getdents
> closedir
> unlink,unlink,unlink
> opendir
> seekdir to next batch
> getdents <- no dentries (they all shifted positions)
> rmdir <- ENOTEMPTY
>=20
> The other way to think about this is that on a local system, there's stat=
e
> saved in the open dir file structure between calls to getdents().  With
> knfsd in the middle, you lose that state when you close the directory and
> have to do seekdir instead, which means you're not guaranteed to be in th=
e
> same place in the directory stream.

Naive suggestion: Would another option be to add server
support for the directory verifier?


>>> The reality as I understand it is that if the server is going to change=
 the
>>> cookie or offset of the dentries in between calls to READDIR, you're ne=
ver
>>> going to reliably be able to list the directory completely.  Or maybe w=
e
>>> can, but at least I can't think of any way it can be done.
>>>=20
>>> You can ask Trond/Anna to revert this, but that's only going to fix you=
r
>>> test setup.  The behavior you're claiming is a regression is still ther=
e -
>>> just at a later offset.
>>=20
>> No-one is complaining about the existing situation, which
>> suggests this is currently only a latent bug, and harmless in
>> practice. This is a regression because your optimization exposes
>> the misbehavior to more common workloads.
>=20
> Its not a latent bug - the incorrect readdir behavior of tmpfs has been
> analyzed and discussed on this list, have a look.

Well, let's not argue semantics. The optimization exposes
this (previously known) bug to a wider set of workloads.


>> Even if this is a server bug, the guidelines about not
>> introducing behavior regressions mean we have to stick with
>> the current client side behavior until the server side part
>> of the issue has been corrected.
>>=20
>>=20
>>> Or we can modify the server to make tmpfs and friends generate stable
>>> cookies/offsets.
>>>=20
>>> Or we can patch git so that it doesn't assume it can walk a directory
>>> completely while simultaneously modifying it.
>>=20
>> I'm guessing that is something that other workloads might
>> do, so fixing git is not going to solve the issue. And also,
>> the test works fine on other filesystem types, so it's not
>> git that is the problem.
>>=20
>>=20
>>> What do you think?
>>=20
>> IMO, since the situation is not easy or not possible to fix,
>> you should revert 85aa8ddc3818 for v6.2 and work on fixing
>> tmpfs first.
>>=20
>> It's going to have to be a backportable fix because your
>> optimization will break with any Linux server exporting an
>> unfixed tmpfs.
>=20
> Exports of tmpfs on linux are already broken and seem to always have been=
.

Please, open some bugs that document it. Otherwise this stuff
will never get addressed. Can't fix what we don't know about.

I'm not claiming tmpfs is perfect. But the optimization seems
to make things worse for more workloads. That's always been a
textbook definition of regression, and a non-starter for
upstream.


> I spent a great deal of time making points about it and arguing that the
> client should try to work around them, and ultimately was told exactly th=
is:
> https://lore.kernel.org/linux-nfs/a9411640329ed06dd7306bbdbdf251097c5e341=
1.camel@hammerspace.com/

Ah, well "client should work around them" is going to be a
losing argument every time.


> The optimization you'd like to revert fixes a performance regression on
> workloads across exports of all filesystems.  This is a fix we've had man=
y
> folks asking for repeatedly.

Does the community agree that tmpfs has never been a first-tier
filesystem for exporting? That's news to me. I don't recall us
deprecating support for tmpfs.

If an optimization broke ext4, xfs, or btrfs, it would be
reverted until the situation was properly addressed. I don't
see why the situation is different for tmpfs just because it
has more bugs.


> I hope the maintainers decide not to revert
> it, and that we can also find a way to make readdir work reliably on tmpf=
s.

IMO the guidelines go the other way: readdir on tmpfs needs to
be addressed first. Reverting is a last resort, but I don't see
a fix coming before v6.2. Am I wrong?

What I fear will happen is that the optimization will go in, and
then nobody will address (or even document) the tmpfs problem,
making it unusable. That would be unfortunate and wrong.

Please look at tmpfs and see how difficult it will be to address
the cookie problem properly.


--
Chuck Lever



