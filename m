Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B5B763735
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jul 2023 15:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjGZNLb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jul 2023 09:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGZNLa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jul 2023 09:11:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BB41BF2;
        Wed, 26 Jul 2023 06:11:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q8QbBu010691;
        Wed, 26 Jul 2023 13:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=8RNaEe8cWG7shh7BzbV9Xcc224/oqVsNRKiFfMxxONg=;
 b=Og44KuiYs4ylkrQXvY5eVaOyT/mZkZDv3EFvF+Frsvh3Zp/fa1HKMhCSd+EYxa36BwR6
 u+joZWS3QRmBFiKUDjD+M5M2OE/ODpOpuH6EYf1FRuokrjuOCRbYIPO8HtJ1kZ87tQt0
 zHl1n7BWGv0/ybpdHM45bL8fwdnqxz8fLegvwmYJTlp3/Fqqq+iuPzWr8T5vqPHzEKpK
 nQBZvmf27ho3G6B2ky8vzdzjoAQ8355Ll4sxIX8DbwdrmZNMG5GxHOqnXQbM1MnYTLbC
 ZIL9KLyoSN2a7SF/6TN62oRBFdVm46HzmHmwxWW73emkNb2gFftM9lelZw0i2QAPjTM4 cQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nuqc6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 13:11:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36QCUVZX030404;
        Wed, 26 Jul 2023 13:11:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jcfpbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 13:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeJABbMGSCYdUs/dKx51F+0umv7wuyyoxpkgTtD1S8tMsF7EMsml5p9wkUktYLcJSHNpaGecBPMtqZr71xjPVz6xjIdRpDukZ5L5gHURisPxfOwcF44ePv4EHQwGeaRrVicfwp5xXJ6CWSCGNp5AbxOQbEXfbN0a9FFvlCw/usXFQ629OhscTol4Vg5xNc+zDPHk6RNpXGyCsRjp8X7Z12le0uuMO2SZJOJ4JcVstuUBAVTtkiWXwDViL8hUXX6fW8/trPS6CxQkk1Ws71xc5FH6Q8hKB1KmZU5V880cJJhfmyRC4M63VCeEtVt23AB/usUQYY0d8ZtmDg/pxgOfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RNaEe8cWG7shh7BzbV9Xcc224/oqVsNRKiFfMxxONg=;
 b=Uc93q3+gUG+VtlML5arrhCwgA5GhhmuA7gCdAwNpoKr3qTRC/UD0eAZ33zCAYgUWLweVIpos8zSjABmDcQmeZbbWzAEe9O7EfOCx9Inxkk5vv0JfHDnZWIAAQ7eWlEfccXD03KjWr/5ayhyfdszuo/6yPJCEx+pRD0x6XzG1j46N4caYPxTk7oP4KbspPE0Sw1ADell39qLXDfgjrdwaNwmP4pu71kPuR5I8AOSuU2ZiVvJhSKboZ/Wy3Pk+i3xjo5p6wS7B7UvDqvKYKdwbVaIxzvWfJmVcXLcMR8s+5yCmx7N7L1WtjWF4oGCPpqjHjKCAEuLBhKJMt0TkwdObhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RNaEe8cWG7shh7BzbV9Xcc224/oqVsNRKiFfMxxONg=;
 b=McuTu7rsCQWE+/vO5Z0Mo/lvV3HfYa6oQF1981Tmnkf4QuUJMS1aBgAeZzaoDxrmJwvsm+FLwMy/uXjmexA1t4MQo3OhdEKtyMfwj1l4b/aNMxk5g4Fr2XR4xi6KhDpwCwBY38QpbJirqrBufBFSrpvh0y6s6jC9zB/0VwJBP54=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5093.namprd10.prod.outlook.com (2603:10b6:408:12d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 13:11:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 13:11:16 +0000
Date:   Wed, 26 Jul 2023 09:11:13 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3 3/5] SUNRPC: Convert svc_udp_sendto() to use the
 per-socket bio_vec array
Message-ID: <ZMEbcfc0hqT2mcDU@tissot.1015granger.net>
References: <168979147611.1905271.944494362977362823.stgit@morisot.1015granger.net>
 <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
 <6650.1690373730@warthog.procyon.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6650.1690373730@warthog.procyon.org.uk>
X-ClientProxiedBy: CH0PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:610:33::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: 812f45b5-f88f-4d5f-712c-08db8dd9cb3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cU6AaM/+GIFlrvoVk6rJm4mAh5CJC0ci3lSQyHBnwyBzYHVdiZzArKCvGpZfMHLK3WndKmoMoXcq++3qxGTEtlc9YhdywU9e/MPfkF4spgB9vhv++ZaU61tVRd7OdkjkpkpNzXoX2rBs14Lnz74UvohVf/6l7YSViHBEy2RVDplJm2Kbvl2EAts2pEGiTRaIBdy85Fm9NfplVUaHPS/1kT33ZJGE0i57J/eHedy6K2NZ8P5l8cGMdpXHE1qZfBk8fuMJ8WV2Xb+Vm9Ga1DKPXKmFLRLnDYY0zGFytesKjHpKcrcxZEwx8L73xtF+z5ZOaE22ZftGdQsU3DZQd2KIEutomZPhjf4flsNiaP+rYGTwMWQVJT+LQYiUOv9j7G3a9rVGuBciS5e2+lWVDDpC6ZcA2dCR/PAerMXJj7ETHAmKbzkE4mxNWG6geTgKMwxvzysTE6a/QLrBSaLGlQsiWgvDu6zAxiXa5yIkFNxZHtYGI7U918EwfMWfrqZtHFVuFYArvYAIfmgkmuTUwcAZuhaPWkhuDJyoB4+JBtUDP1wlf7dfefnbl4RlKPXaTlfh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(5660300002)(8676002)(8936002)(558084003)(186003)(316002)(26005)(6506007)(86362001)(4326008)(66556008)(66476007)(6486002)(6916009)(66946007)(44832011)(6512007)(9686003)(6666004)(41300700001)(478600001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UBKgikAASGsf5Hjgu1VAPb2zB/UuhFtn8iHS1ZfdxPemBPBNIlqeT+j0CgX6?=
 =?us-ascii?Q?Pxj1IvO6ww2PEjmSjyfWQSLnZNiRjpYJR12OXvkYkAXWV1rBv5sV9W5zEsFC?=
 =?us-ascii?Q?MKe54RSo2kNiGYiW0Sl6HKL1H8Z41SUpkEfCWJeWQJjDuG2NXG7p4VJCjKVl?=
 =?us-ascii?Q?1OtFqZ5EJJ6MQqOkxq4jU6Z0mfgMb5WOQE1/mwebu4GxWuDqGbUmKL6ojWu2?=
 =?us-ascii?Q?lJRR8wBV+eeVhDMb7ubHLNa9Lig7X1H1XEgIQ471/IDdC4Z6k38dIim8u/mj?=
 =?us-ascii?Q?/jMWyMyaCYpJsnWgZ55Cbqzk+cbY4qBgmnKOdDasinCUsW2CcxcfPe34DUoG?=
 =?us-ascii?Q?nRxku2hYU4TH4ChRCq3mLnMjvHZ3Ubccd6TMQ1b9De1Rv6/rKlAZ/DEtYxBI?=
 =?us-ascii?Q?obp2ynU1RkFij3eT57wOAVSLVeVAVqk41AfiYqaKNvPcgY4IkDhmL/fD5vOk?=
 =?us-ascii?Q?MC1gSrUmwHlRezlrDr8cNp9ddlXT7ftGATTTfDd4A8LZUye8niYcDQA2Tpt/?=
 =?us-ascii?Q?X4icC8S8qmSyexbNALSKVddchddPG44SV9nh8uLzEmXMSOAUmi3djNW0OQfZ?=
 =?us-ascii?Q?B72BTha06CgEL36EAFsCGJbymQVQEzQRNwY/YukEwaJR6iO+5yER1iWR4s04?=
 =?us-ascii?Q?FUbkNJb4QHdHo2rSerdQeGEFOTXALtm+5GI4c7l72nOKCAbHIlNQoNPZmPu1?=
 =?us-ascii?Q?lRkNt945H9eOeUZZZaFFHn9Q8X40N1QmmLsimfxJC8eiumTzzIWPLBe07JkP?=
 =?us-ascii?Q?L8zatWnb1Yk5g4kolRrkxL6P947SIFikBlUU9m3unMtGth54OdixuN9vnIJL?=
 =?us-ascii?Q?0v9Su8ZJb8QlK/686UCFdmxKcX+iEKEN5JZz5ZwUHGIcP+gtex/cXJ02mXLN?=
 =?us-ascii?Q?pMKBrO/s7Z0txe/P1OAlzt0n3kkxQwHIJ+EzRLM/XFPk6h0/PJyP9PUrff5/?=
 =?us-ascii?Q?FMr7PoESobzqYBz9Mqc1YdQYAxveA7A3FBEYvoYSEmrozw6QKRiky9K5Zr4N?=
 =?us-ascii?Q?csJQQD46AxCpQtCj8a/BuFKfgaSkwB5b4DJikr404AVYBJa1hzIjEQdp7p4A?=
 =?us-ascii?Q?bJV5MteXccUTqKLAbvj12T0zUf1vbhtSOSd5NTjaj98TvCz1LoR3I43UpjqW?=
 =?us-ascii?Q?6FGA/ZpJNCMUX5dCeiBjKCxtrhQ7eMw9SWW3i4Psd1Aulww2kKTouBRszquY?=
 =?us-ascii?Q?u6QSL+2RD8IrWgf+HU1vS9aRHveQy8Os0iBjOqf2QtIFxKghzSXfH4/58AMV?=
 =?us-ascii?Q?rPJYFKRoPFC4JaKloP8NpT0/K+Fgn1HfKuAH7XPAQV+lrks7zp2NY3AyO1Zb?=
 =?us-ascii?Q?t23hJRbv/A+mcQCHujEu7/LBtE4P/36rWirsmtdO93m4hXrh9ydThapIkV1Q?=
 =?us-ascii?Q?sURGBlqsXaJFzFYzLn7wRn8T02KLy+5mshoBF9iREAuFHN5CLjFP2v0RHUyb?=
 =?us-ascii?Q?MA2gOI7PheO1qgOU7afG0ivWXduYU/0MwGuM9NDdXXk92rvrRvjMnl9H/bfb?=
 =?us-ascii?Q?az6cGoBXZA1G7umVUUnlIVxu3S3IaFRwrdYqJPuyvtrlMdyIffv2Nht7eg1d?=
 =?us-ascii?Q?XJ23YkFNH429mdjd9ZFrOinK9HlJxFAyHBbe4sMmAyK8Jtg6aIuS0bZZeLX0?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WlCsBMyRULo5BL6BrgO4OFMii6SwBvqPErUIdoINBVChY/j7mJi10nrQtuLx30ScelSeJEBXHIRX0ZBUSCdQBR2vYHMtoGKc+nhdhIu+Pi9BueQAXI23pWRCaQ3+v7qS0LIBSvxy2/A6E64fNnGU4doE5h8MhL3wvbQ5eEMWRozbmp1r4OWao72yZaTEYHT+v8r1yVIISJQ6qRbajmsoJdMRGGb++cYEm7pXyjWoCuAsYEbJ4046CkzEEi1UlCr3iiw7ym5r0QcXtXwORM3NBEZrJHakLyqxzDNuZQEpqqd1NARc2YjPLLESKWczVjrLtf2GR+3tOP8jOdzBfDGdaYgnwEVR5CMfOK+rCt0oPE9clT2aUPJcuiKucjXw0n/h+IpfzpKfaZMC4XPrKWCWpjUZeX6yM76Ikc2OKXZudKb3ZkmxMXf2NUjKLoguOcV9zng9DApolk0ymKp400bh6/UwpbEGy3Q3PvLLqVa7vp1lAvmpVVzGI5QKftytzOO+l3U7IovV6Eg2eEni4FwBL+7GG4MhgJFL1st2MtaR4Rvrj+Ov282283+ineUufPFlRorgh/wWxBo4atEIqZfdJ9qJvNAimHVD0dRmTOZuvEnHPZmYdyQV3bBmZOQynR5a0QbopEwQ2KLxl9Ju8oHWvWHupJ4iKN8xgfcDJrriZ9uXyr71c/qGpPk+KlGCwk6RGdO8abWAGGtBo/OHMhfwicAeLpL7M1GPMvqF4dzhVNZZtwocvFl1coJacAymUNvt3eDCoejwqJ/AEGTTZl/jr4GmeHjI2HA9qIfBJD5/pijqlvoCznGtlfZOZgzkJ7JF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812f45b5-f88f-4d5f-712c-08db8dd9cb3e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 13:11:16.2193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ss961g1Ugo45n2XEqCSsjmNOsjobYwnpx+s2V9A4KmMtxs/iECOUyCE7zoN2c0AjAArv7Bs39E9cGNr1zysFNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=723 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260116
X-Proofpoint-ORIG-GUID: EWONM3QnQs_roNKQA6c3xLRADCYbH7OE
X-Proofpoint-GUID: EWONM3QnQs_roNKQA6c3xLRADCYbH7OE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 26, 2023 at 01:15:30PM +0100, David Howells wrote:
> Should svc_udp_sendto() also be using MSG_SPLICE_PAGES now?

Ah. Yes, it should. Will fix.

-- 
Chuck Lever
