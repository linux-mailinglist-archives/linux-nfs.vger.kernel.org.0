Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFD66BEC1A
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 16:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjCQPE3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 11:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCQPE2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 11:04:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF8E10DE4B
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 08:04:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HDTJxf032292;
        Fri, 17 Mar 2023 15:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qCXMYRw28GZbisUwO39ynRHi5fR/GFcRdavyEt8nEiA=;
 b=E4C02cDT6Uy/czzH8SfxnvYMRo377BiZEm3nnOADPqEBPBKwxf8yQOY5AAKVDm/bFP70
 ll6H8pQWq7IrtpiRduxK/kTzbhsdffhHMsyhJSF6zzWPlg7P+bbVrClHFrj+6peczIHU
 1wgwaFurlGsfD7T2XMo7MHhRBTTm9rIJpsFDklNuqKm+oB7f1mLI/AAyPfqveym+Fdkh
 XB8xL99IFV/ie6QyFsnOooL3xLzociqbuRb6YmABSq8/qxIMPBNWAmqPHqVi901v210u
 713SdmZ2hSi+zyybwUvEl6rah7XQ1i5p3x2ruq2LNInY8X4RRLXbV5yzPo9N2Lx2cBQ2 Mg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs293yuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 15:04:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HDgNSR002590;
        Fri, 17 Mar 2023 15:04:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq47vwd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 15:04:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKUefefHtTzYZPzwhAb4TQk4XabQoSBfL8Gh0SIJCGZ8KkuMhJ2SpFPpDmbfI6OMjLOa8BB+az2PXVIpE+dv4+t63qQFBH44dCfOq0BelhNtp58w6csLA4tTe13LcQc8zVWCTEyUcREBXdfkWOMdlVxAA/J5XmqUd2Mvc7xcMFPAn5NLk84GhBj8NgxlXdJ7R+qf/d3dVfgEkvJwoOxv4fNBXVtE42kJSzPsLLMJwqCXQB6hK6hoy5eQHsxtysByUrI6S8bGmBzJrb+k6EpJNFtulfhyWr7Ji46jBsKFio+PsfVhiC8h/+FG0QnoTzbCon7KHeQ/x5YjaBs4X02FYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCXMYRw28GZbisUwO39ynRHi5fR/GFcRdavyEt8nEiA=;
 b=aEKoePB74Ur6Tjbq3tLxjYuKKxT3UUbvSfRiYENZrg1ihaazbmE+PjxAW6GAuJnvys7/DZOAV5YstX8ds8vzMuSkOBS8kqS0+k3Fl7tsxf7sPQzgdD0aEa9AQXlTJgw2Dv8sZ54XD4YHwyDau9rqGp9VnEDVjBzkG4oEPPzWiNzn71eUUAMTRaUDSkLDWjFFCEmOeco8Yw9O+kKRcy5k8qFLxi17Ad7gvj4uI5eMvx2ASmGpPMynFYrN6wFvvxnVY51KmJVdYmXMNgx4EGRBl90Tyowf6e9qDFECm7KZiQ0hQFTr63ZAbXlxYwYaHS3rNljsrBLMURR1VE7kbIrwLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCXMYRw28GZbisUwO39ynRHi5fR/GFcRdavyEt8nEiA=;
 b=RY2yzvpq/5FOd4I+11PW20tW2LZABmoaYjlP8qqiZj7ZaRx6xKF+8gLqIjpBZzQk1g3nHYlTmMmRlxM+YWwHFGh29RrfmrV6ao48YbyxX/TwANno2KKe3WGJdWtRyqjJ3NVjfyZYT9EaKK9ONN90z+WYvaywlLcL3gozi+du07w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7273.namprd10.prod.outlook.com (2603:10b6:208:40b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 15:04:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 15:04:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "dcritch@redhat.com" <dcritch@redhat.com>,
        "d.lesca@solinos.it" <d.lesca@solinos.it>
Subject: Re: [PATCH 1/2] nfsd: don't replace page in rq_pages if it's a
 continuation of last page
Thread-Topic: [PATCH 1/2] nfsd: don't replace page in rq_pages if it's a
 continuation of last page
Thread-Index: AQHZWL8bpLhVrwRqqEan4MoWlxHuRa7+8Q2AgAATp4CAAAwUgIAAASiA
Date:   Fri, 17 Mar 2023 15:04:05 +0000
Message-ID: <9EAA4947-0139-481D-8D0A-6DF30444342D@oracle.com>
References: <20230317105608.19393-1-jlayton@kernel.org>
 <c57b48f500b859a3daf6f95ccefdfbec72e1c9de.camel@kernel.org>
 <65C84563-6BCD-41CE-AF68-80E1869D217F@oracle.com>
 <c1d4fbaf83c6e1e41e31f77d58d889adaecb6d35.camel@kernel.org>
In-Reply-To: <c1d4fbaf83c6e1e41e31f77d58d889adaecb6d35.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB7273:EE_
x-ms-office365-filtering-correlation-id: 727a7237-f1f3-48ca-0c26-08db26f8da3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dYCIUU+JTr0700bR9/n2Tq+EhvfUA7f85f5KfpaDy2cdU4awnqgNxtv6YDL6SrjavHbJF9E5j4Yb3NQY4RuUES7DxuDsXPpgs9sJndXewE4Phfnl64YnVprHUAoSRyq168yq2MDeVII+zBlUOF0Q4NsNjECM3rIiJynzH3A8C2sYJFhJvldNoJE75rCsjVesm5FHs9nnzAsuoHtGXMw9x0koLbj/OrIyk0Ia2mFJtwlWafQBDP38D0o/hohc7Gk42Jptctm08BAIewOYEYrvNLwuq3070/54R5Yjw451+F/SK2I1i3mgCGjFYfJKK1GLjRaGC2ctRuDsCiFWpT+Gho5ZTHE9aM8jQWy3P8WzTxzy3umoAkqlZ8DgfnQypOsmAIGE5LEFGM90diMA23PmPbM4RUOk6xjBuQ3Z45yvU85L9ADSBadclHlCmc7gQJigOTAu9RuY9kgpr3O4krxwU4tJeL9eqofkIlmxabTLYsZjyNd7R7IxlcPNhKGojblsv0PYGcIspLpuyQyqun2tbsTHkB8mI3alEbMJrKUCwBOKWd2UgtCkAELALMuVz5D6S3YKtvkIBDwbWDM2JdjS8kDS1PepD9O/KVUd/d38DNYH7d/aq4oAm56Pkmltn0N/+yxg463T1LbwixoN9gJOwH7jmUBGK+Oy4pevcEghd8alAy3TeX2AxeXDhQf8T8U3NLfBphIMXr2rCYuzmDjbIe54tKj6Q4JSFI9s9EJhAaA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(478600001)(316002)(83380400001)(71200400001)(2616005)(6486002)(33656002)(6506007)(26005)(186003)(53546011)(6512007)(36756003)(54906003)(38070700005)(2906002)(122000001)(41300700001)(38100700002)(4744005)(5660300002)(86362001)(8936002)(66556008)(76116006)(6916009)(66946007)(91956017)(4326008)(66476007)(8676002)(64756008)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9KLg5bOnSuBYEPZKe/O3dy3dyT9Eb+cKEA0oIn//hkw11uux5nvfYg+fN8wO?=
 =?us-ascii?Q?1t/jCr/yxzCaJ6Wt1gwpMEQ+c5F5cVi6WwH0iG4RUbV15UYzRAziOY5aUd56?=
 =?us-ascii?Q?WuMLKqwOEBxZhBSCslyowYi8vEnFeQJF6ObhHIah0XrsBL5p+V/1IFnZn0xF?=
 =?us-ascii?Q?m5nCIZMPPe0PahJ8AmBjZO9yDyKxO3u1eP1QqqRSgTmQcA8dw0H/T4cfWy8s?=
 =?us-ascii?Q?hHzOMjTicmyg+xeopJGKTLxQHOetyg1fdZ8m/57NR+bMC3sDawdQeolnBHU9?=
 =?us-ascii?Q?OblpCFXHcmn2QzaEsSwiL5qntuHGdgYqZQ/rEphjQTzY8+ff2ISJtm3LRjsk?=
 =?us-ascii?Q?WNNG0jkRe0+Xu8MO2uzjA8yvbmxY6Yn1OGpG2eLZRz7nBrZoDTo++NtfF3Fd?=
 =?us-ascii?Q?IjfWcP0+0T36s+CJWHYyoWcFP7AoyEF1j5dR66ne253JniBB3Pe4E48JvvyL?=
 =?us-ascii?Q?O0gPNzYRBQBGbzKi5XFnBsG44XcqwrO4jC7/kBjG+kjm2OcAssWeSu42/Z0s?=
 =?us-ascii?Q?6dj4U0hFAzEQbDQJxcXXyq5RacS36PlLwAbQF4vn7MQJWHObOmkgWz3kVqKi?=
 =?us-ascii?Q?IxnPn7iC89zG2g/DE8tHm6gk7pOahRvRphGgIxLz60QiVu9zNYLkavQ1Tonl?=
 =?us-ascii?Q?w7ndqkoBbMSnEtPXbQLo0TZbOnrpCh4pOJJkj9CNsFe0m5U3vK53TYkvqYPV?=
 =?us-ascii?Q?vMy+J252Lsg4nloIF42XqC5pSzU/e7OGycmLh3srZwAqpP6HRGElzxKLkaCW?=
 =?us-ascii?Q?gOj5zPghCyRW6UlF3NBiwl1gbTwnFIrXQ9AZei8HFJdBqZIca5Sxlghq8/to?=
 =?us-ascii?Q?zhsAw6kHTOLqWmQJNCdUPSNHMfbR5OH4c5/iunc9eh/siwad2YLFqyykoWn7?=
 =?us-ascii?Q?7zvuvIa31zjj2QyG0f0BDSkj2WRs+CofjnwD63dv3OB9XvyJDkBjmAAJm8Pk?=
 =?us-ascii?Q?jbb4dPwubgyVbcxq6w0MxP/BTLpldkCHcqar+hSSDEN8aR0fK57W/rLM1wQi?=
 =?us-ascii?Q?RztpPaFKPSgMYm5je8KcCNt5WhycOtyCn660UOIxUAkEbBA6+vGP+fOhVp+e?=
 =?us-ascii?Q?a5awl2yVadTAHE/lY0hxaN3Rx9Y1pvARP58wHQ04VIfkBD+OVM0OfECJRjFF?=
 =?us-ascii?Q?gkEaG4FB+mFaHfC5pj9h/QyIoGd5gCkEE7Ellc7/9Zb6rZss30Z64JSlInmS?=
 =?us-ascii?Q?Jz7uyRYjqFpz59az8QMHSLJeH6kwdSQgSPGL5bAQXjJi9ATkAb4FDTnKtIZV?=
 =?us-ascii?Q?FaQfURekCP24kJp/0vwMoN6imEAI0O/wrOx2qgbNuKCRhUD6sWVnUlJsC2qc?=
 =?us-ascii?Q?YbqEYftgMUiw+C5s9EXYlQd5zLxnEodVSf8Fc3bEZjumr3oI/pT/J5XBoHkp?=
 =?us-ascii?Q?6NJzv4ruYeyImxsA27IxL9aUZ8XSClDr9NeE8qEGhCPDgtXfEzJt5+QmxHyh?=
 =?us-ascii?Q?7yWU7soX6Vff07TYYimSGmi7yuigb3mcPmf6xaK76EEw7sPeseKJsG6DYE+N?=
 =?us-ascii?Q?+OdWAx7OJiUdgYaVAZP0jIg2XUJZ2YvQ/7dYirL1CzFoJuuTsqx17LSpNIQB?=
 =?us-ascii?Q?scdioUrBr8XJsjuIly9aSuXX1IRgA53mg8+lIiGQ5cTv7pl1U6BvRyXYBJfZ?=
 =?us-ascii?Q?VQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B02767868C1F32418283F7136B3A4793@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dRU+OQaKoSxtCZh96ObU+JLqx45mvFyvIKKn74LfCqbHIpMxW/FM0yIfhhTAztuWBeAngp631QkGHmE/osc8XKCDhmBnRxFO/DkHdlJoHZbLsZKAGsJ+jh+fFcn5uv1NXE3f5+xc+T6w5FP1zXrx8o0bheZMBCDbS3zAYNw/PbCdc1EEwtMiJsbJHOO6JW9MPUyZ+J1XFOKpZkjkMIoucFb/ChsG3Vkf8t+tmJUlOTSWwTMdJlflzZ4as1uGApjjN6rbCiyTtQxFpEw+uAUe+B5V0licjatJu7OsGQt4Rys0m0126u39Nxo0iWWopq6umzhIVfzoRmFOLfWg6Wv3f7UOj8uGSY4+B23ywLrJPHusdFC/mwlm0R9QANwLL6E0H4Btp0i0wAzKr8QH2u6yj/pGVPX2QhRgpPEiy/jb5nKHLrHvfJChhGs7xlEC9eErxBffr0lWKxJwETcX8hZQDoLGTzFURw8UixGAaxbAGz16toN1qpMJzPt08JYumyjU/05TezVcMl0uzOqi2dSLyx589JXEgC711jb36Mm3r24aEq3AmEnFo9Ug1Q5hEapUKrdoss6hSEFROFg6wNf2uZDZ5eU89j3usazL7XU4oIOvPn6GJPuod9Wm9py3AbvOcumFabXrVQlj+M1cwKQwTGWTDLepjn9jifiBdLEPrpyLDV/FAdhXK368JmOsoZnAwEIVV7ateEMtO7TWM85fO3AFbj2r4cwyqj3xRD/HXEvSPYDqJ08QLkUNZtxIKR0LU6NfWgLK9/mpUMvLi3n2uz8CtTQLmKQAaxDZSMNJ8x2xQF8BTloTphZ1CThN8gRDmnbxOfWjyTAlXWcWAAlFVH1AUXHFU45N4wxxfcFvKKA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727a7237-f1f3-48ca-0c26-08db26f8da3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 15:04:05.7742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KLAsn3R6Lg5oxMidGUThKEuORpeG94SAo3QpRGuRxdGKpRsMl4CTiU79cDBMJ9cFmYY7r3BKiA3YEzln6KlwCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_10,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170103
X-Proofpoint-ORIG-GUID: 0ZtQw2EDtBIyPsSQowDBJQzTDaZ6xK_4
X-Proofpoint-GUID: 0ZtQw2EDtBIyPsSQowDBJQzTDaZ6xK_4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 17, 2023, at 10:59 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-03-17 at 14:16 +0000, Chuck Lever III wrote:
>=20
>> In the patch description, would you mention that this case
>> arises if the READ request is not page-aligned?
>=20
> Does it though? I'm not sure that page alignment has that much to do
> with it. I imagine you can hit this even with aligned I/Os.

Maybe, but no-one has actually seen that. The vast majority of
reports of this problem are with unaligned I/O, which POSIX OS
NFS clients (like the Linux NFS client) usually avoid.

I didn't mean to exclude the possibility of hitting this issue
in other ways, but simply observing a common way it is hit.


--
Chuck Lever


