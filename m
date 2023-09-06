Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5587942B9
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Sep 2023 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbjIFSFq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Sep 2023 14:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbjIFSFp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Sep 2023 14:05:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A35E1738
        for <linux-nfs@vger.kernel.org>; Wed,  6 Sep 2023 11:05:40 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386HTrKj001461;
        Wed, 6 Sep 2023 18:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SVawu8NZ8vd0/k5aSLrzaIVucyhkEyVnpCm/GQn2CBE=;
 b=YNVbCdRCGbfPXB/6Z6QVlVdkTFT9NeXeXoQgCsTJoONgBMKgul98P33g7H3CNXs5Dzpj
 Nrfm2u+mxt7YnrUVBZokW0AaXSO6UIVOjYgLj2Nyhn+O2n5n/IA5aJJ5zgtanJqXtF+l
 bYq2q4YU3oTtw463R1ulRU1EQLH849obCOO2sIyODXWbUdZYsTtWWv025SJLcXw82jRA
 ZDKiHZDCTuWjn1WsCiltDZh9oEUXsjF0lp+mbNGa3sNHympLY5+L64fFhG7bk+PyE91D
 0GGTZzikQjL6iQDi5bv8R59e0CVoq2vbFl9pGXYQh2leQG6T7Lz+wWZDozjlKKno4NA2 cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxwvc839e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 18:05:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386HtAlB010491;
        Wed, 6 Sep 2023 18:05:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugcvbtv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 18:05:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hezx+U0svHHkzDKZPqqA7gp91kSHhUMmotbVnpRhEHUh+cpLxAYVkNPNPZ6xbEUqaxo398mNpVGCGkX0gYSdl5ZgNDKc8s/0tM65SOoOtnOQ5spBo2jdH50T9CqbStieCAie5y37zpwra5p0POBpM0Xl4E0pFZuyflHiGQw7oU+qA4eZRXtNr7JXvaiXh0DIo7/SA9N1a4lnS3UOmEQFCPiW1aLVGJ4FFYTuLoRitPBHHe4W/R89YTqtwpK8TEUPAbJuBF0m5WiwdU88CeGjRhlYjpdJbxuW95AK28AopsZpRU9AhTxs+4HvI0ksnCe9YpEyAKxvMpKLa6u2o2zLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVawu8NZ8vd0/k5aSLrzaIVucyhkEyVnpCm/GQn2CBE=;
 b=DSUxbQ8Fb6m88LW9dB+vWzJrTpRZacjI+/epqZazZCYfZws4CzPbWJZxmB0NF1PWy6A8ZCwJzDmA0j65dItgmHlIBXi4yig9eRkR+imjlVKH/wgHK2pbDrU5FnAFHX2+j4a/ELGzcq/lbgNeV2Wg4srJbhdndCk/g9EPOBUTe4TED+mzaHoOwHQJTYK6UXoHoYcmat1OezzdEHrlWnTtn0qCxtNh7iw6kQJt3fEWYaESep2zxeYtgs9zsQZIUCXHsVzi47XWhXax96EyKFEwa0PqH2imbj+aw+1p8bTG9PfIlzerbd+nHib828hC+FrZh3Diaz4CgR1ZxKrBS7P7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVawu8NZ8vd0/k5aSLrzaIVucyhkEyVnpCm/GQn2CBE=;
 b=AmV1Jfgh2Jue0gzDTE/YAJqNL3WlngeUqf9/n4kKQUMtKkDLsDDlfC8NevPvWGF3Fuzz03FqTa+OBKxUhAZHJDYjDZcFDX/4c2h78pR6Eg+1TygUmOGTdX+vtwUwxXUee/RBOdBkt5xmHNlRT8DwSQ5/u5s3wUN3Td3NXLrLNx0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5595.namprd10.prod.outlook.com (2603:10b6:510:f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 18:05:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 18:05:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@kernel.org>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Russell Cattelan <cattelan@thebarn.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Revert "SUNRPC: Fail faster on bad verifier"
Thread-Topic: [PATCH] Revert "SUNRPC: Fail faster on bad verifier"
Thread-Index: AQHZ4F7ccnSO24xLIUyt1pMDrzj157ANzr2AgAAOn4CAAA1NgIAAECuAgAAdxIA=
Date:   Wed, 6 Sep 2023 18:05:18 +0000
Message-ID: <36A61B31-5D22-480F-979B-82A1B512F555@oracle.com>
References: <20230906010328.54634-1-trondmy@kernel.org>
 <2854B02F-61E7-4AD0-BF7C-0DC132834416@oracle.com>
 <2308819c5942088713ae935a53d323d3d604cd8d.camel@kernel.org>
 <15DC398B-F481-4FD4-8265-603CEE2454B6@oracle.com>
 <453cd9f416164a026e0932778d2bbcaf04dbe572.camel@kernel.org>
In-Reply-To: <453cd9f416164a026e0932778d2bbcaf04dbe572.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5595:EE_
x-ms-office365-filtering-correlation-id: f602fa60-b116-4e40-abe6-08dbaf03d427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U0NTvPavuxq82O5MRpMRZ6LjXrNJf4yJLf0cjha5fltvHtewQk15CTw2F6GMS47Q2ZOuKz9Uw1IfwHvyrZmzJT4MiuuN8SQMbASZkdQm0zbRDoi3MrKKjiPYGoWzlly6gW+gxxBxl2oZfnuqFQYU9H+eMOxkp+bOI05vCBjdcYQoQIMOb0olkkRiVNYOphw2acaXjwxNqDBlx5t/81W03n+YXzKmxnFFbBZxDYgtxukGDw4rNLT+lZalUYM2g7Ay19kNXYpY+vzLNAsgYPFkIx+a3BnEgtY3ddRtn08aSsVurvHkNY47d9dN+EGI7M4+TfXINh+AkQj4tSkydUrmB2AdcKHCj3weYmLPtsMuvV40J6KPFfUAFIw3HRmlTfteEAOMkA0LY3xnc/A/CNlH8uYRrBupt9yXGhyXRLq6ZR5Q4XuvsVSbdsIWimkE+UuW8fhfeTDj4x67T+enuDkdP9GOlaEOR3Oz502zjvJ6VneboQf6rjX4gf4h8CCUvfVlTWbR8Nq7g3QSq/SzrqcIMKRdM5kgXrxJP7D2emqE7XzTqzL4A+iMXpTMVRAiU9277RmNCH7e1tucSmi7pONewDGPXb4oG+p3d5IbZSNpPOLf5T9saTYejqaWLM531ktSvznHnerYCQjL/3Chia9YQ1TX302ZMKSw8cSr94ubJxgam/K+1mk9gFCbkn0HZZPs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199024)(186009)(1800799009)(83380400001)(26005)(2616005)(5660300002)(8676002)(4326008)(8936002)(6486002)(53546011)(6506007)(71200400001)(6512007)(316002)(66446008)(66946007)(6916009)(66556008)(64756008)(66476007)(54906003)(91956017)(76116006)(41300700001)(36756003)(2906002)(33656002)(86362001)(38100700002)(966005)(38070700005)(122000001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gzTVJmckpCzJQzHhQuG+4WHTPw194veaSkIVdDQVBgvmGTum+7bw0YaO5LoL?=
 =?us-ascii?Q?W3TeQTNORuf+/no7BcwrdQE4S2nB4aPxTVaaxoanxtdEzU/BrNb8ULtqQcoQ?=
 =?us-ascii?Q?M0DqmR+Xg+NsSCohRfXulfUIXN+pf34N2RyMhyhSkG++i8UlfKOTqDoQTtzt?=
 =?us-ascii?Q?4wR1U+6eHPt+PzR34lIwNPtpToEU3s6+5hpPDnSYvf57Szbo0PMAexDqjJTT?=
 =?us-ascii?Q?siDWm8aoFcy4+JYth/oX0ZptF4wEtIH/Uf3idpQZshMXA4WXWzlWmnzVwkZ/?=
 =?us-ascii?Q?lFvT8p9DEYYFgHiETPIz6VkFdqzrpQDRGgQWpsekcD8QNQzwTy4ILGLzj11o?=
 =?us-ascii?Q?2dXRoSZzCzDSe7cJXQqIYvY3lgnyox+CsSjxHW+rUV9do9xZblWJ1LGJlCAM?=
 =?us-ascii?Q?+k954t9YHliDDmrtaju1MPPhxzVVsnSOVRGWooDKIjIC2d8MBTANdRWM3jYk?=
 =?us-ascii?Q?K1VZl19cKAyg9+JtjzBVl0nNnsOb0MZdXN+1K5Ba56vymcpO37jTKhvC9OVz?=
 =?us-ascii?Q?komtyqXgBTbO9B3qUI6hzmCc7fDJsZ1zKoUX4114YpdQpWB/u5naFZ4TKwjU?=
 =?us-ascii?Q?iDDeDslhADT8RXhi/AbZNrjazx1hk/9dgWbfl8G3ZR1zm9fbTsCFpoVr/BnT?=
 =?us-ascii?Q?u/6WfqHUSKcJxwuJXAqMbuHM/CRQPDFSOM+cPgmBA2WraK/FeJ+JG+t/Avd8?=
 =?us-ascii?Q?gCPMA1W/zC4qe0zBS1XCTMFRwUavFY++R7uyIvqflpyoqvuTSKhFUU5kggVG?=
 =?us-ascii?Q?tKxv2LWKAjnFUbqBPluEJDXek9A3VteJdeHyWWc2JdIs/8yeWU+2T0mvgIyc?=
 =?us-ascii?Q?D3twrqHL9gdku3Jp/sT6nYvlJeTJxIq1Qm3dz/+yznaNYyB9y6Und+XLcEgW?=
 =?us-ascii?Q?vGE1TMkaxvlLCi1AP/NGr/i6+plKoFSvnOM+xHWasSqxZudsf5I4utlEH75z?=
 =?us-ascii?Q?qPv1WueVa8rEwXL3R/G69ikaRxVtUWGf1+crk+WfCWW5gMQsnR55f6wB/adX?=
 =?us-ascii?Q?baDkrW19G1TeCYaeTV5sQy1hxJn+RPvobBu3Cfn57bgdQRUe/w6VIOTpIfTM?=
 =?us-ascii?Q?0+tkKP4NoMcosnVhIKtTgP7Or6J8Bg/jEPcOXjDyF3KR2h2xHMlz6Kht7Bry?=
 =?us-ascii?Q?c9dG53yBavQaJAZUyK46KqMLKRXx7JlI93+72mBPtxG6lZOKX24P9EY9AVL+?=
 =?us-ascii?Q?Go1cgM5n2bDtsHwpaoJXhY+R9MtVf4S8ARio4OrCqZFpISgnMB1BO0uFxKRZ?=
 =?us-ascii?Q?AyLrp3/09B3Os9mwgNlXC43sEcjaso2f1luh37TPfDWApflkG30Gcb4Y0nVN?=
 =?us-ascii?Q?kokmvlx7tJrE03gsokFjnhwKtpZUin6MWovznnNSzEFOLW/4Uc7wpnl/N0SM?=
 =?us-ascii?Q?0dyVzUS+B9pTOIFbWjJD+OJqb8RZ7inxUTiiZ+CMAWc64PqsdN8L/s3A8p1v?=
 =?us-ascii?Q?L8BT6RidyY+Dju8VTs2TCWdl5ZRs1KC3nG8fYGuYiPqfsjr5XtKK6lJN/0YH?=
 =?us-ascii?Q?Onv1PjY2zfTLaTqjBJDbd69oc4OJ++KZEaH1ElORsOJ7LBZfUO7IiiWxOOgr?=
 =?us-ascii?Q?VROaHofz3XCx/JbnI6eS/TOTc81nUC3nuK/fwAGy0XIO6SfRLcT80at8fBun?=
 =?us-ascii?Q?UA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CBFC92A124736A43B6B0F1B9D062549C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iWCM6hxW9ecNSE+3k8vvMQeNeyIgWCsfa4Z5jeHF8J9s0+djtKRWPMd22wLX9JzLuE9Tv5nUUcuC6k7fY/JRm6oYMhuEKrzXvCd2emElTvf/AHY9N5FycjQuGbJ5EPBF+EK69U2AtwrpR6kDZXPLY56ITYiYeH1G1Uqcl2hIAoVuK8qTW26eKKl+cDgJN+io43+n3uHbvy2F5hq/32Qstf3L60auvbkpBCRMadLvMqD5Ga44InuZNIxTxL2IGZMI0+7YAA1HKlHneQWZJELSGFJ+vzg1T5kjKwt2fRhl0xvYpSUwmDJhK4a0ghueEeAm+81yy3A6D1rSYpIDtrjpUmVeubN0R1vQLxu6xQu9JqjXP7qSu88NujyQdv67jv0SN4IMFBRe3h3/XGG6eiugADNDT9i749I+sbQ9OMGjUhfEOCC47LpLXRCYKUizs62jDDhsAl1FvzPFQecOe8IQDOTJxhQq1UMS/3YIpvLPBr66mIlZdl8DFoRbaMlm6S5EYmb0MDi0fA6k3b3NFt7jBdTHzHgQWxmoToMlNyQbMs0rf/9Hcb9ans47N+/woxaoxdXvuBr247rTODVLfFX5ww8yUTQVkCYJtFkR0yYpuooNfX2LxGDk9bznnmjrt73NADfjNbvVnvZRTnivXo4xrW1d4LW/UXavte5I/PkAYK70yD8f6u7jOyP8b7FA6XHQW1UckrRmPXnAA2cvlj9Dmw1v3jUjmIpYrD/c9EslY9SAURSO+00Pq3RL/qSSeUNx3zdUQ3DXjgsotCdt6F8EWwS7dhZHu7RgZWefwgp1foeIWwzEmXFtrQ+/RUnDve1O4Wkd3OLocZaqyMETgh79dPQcQOB13/YIGyQbqH+/6aA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f602fa60-b116-4e40-abe6-08dbaf03d427
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 18:05:18.1628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E8Y4/X8qZjlUHy7HloBVX0IdmyY90hewSpTRwRMU1AekViA4Iqr4JpvGCeESNz+XIr+O9NHHcl87g0nhSs1/fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060155
X-Proofpoint-GUID: 1lZgwtUEnTimqXYLXmE8J0DkOyZbXLne
X-Proofpoint-ORIG-GUID: 1lZgwtUEnTimqXYLXmE8J0DkOyZbXLne
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 6, 2023, at 12:18 PM, Trond Myklebust <trondmy@kernel.org> wrote:
>=20
> On Wed, 2023-09-06 at 15:20 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Sep 6, 2023, at 10:33 AM, Trond Myklebust <trondmy@kernel.org>
>>> wrote:
>>>=20
>>> On Wed, 2023-09-06 at 13:40 +0000, Chuck Lever III wrote:
>>>>=20
>>>>=20
>>>>> On Sep 5, 2023, at 9:03 PM, trondmy@kernel.org wrote:
>>>>>=20
>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>=20
>>>>> This reverts commit 0701214cd6e66585a999b132eb72ae0489beb724.
>>>>>=20
>>>>> The premise of this commit was incorrect. There are exactly 2
>>>>> cases
>>>>> where rpcauth_checkverf() will return an error:
>>>>>=20
>>>>> 1) If there was an XDR decode problem (i.e. garbage data).
>>>>> 2) If gss_validate() had a problem verifying the RPCSEC_GSS
>>>>> MIC.
>>>>=20
>>>> There's also the AUTH_TLS probe:
>>>>=20
>>>> https://www.rfc-editor.org/rfc/rfc9289.html#section-4.1-7
>>>>=20
>>>> That was the purpose of 0701214cd6e6.
>>>>=20
>>>> Reverting this commit is likely to cause problems when our
>>>> TLS-capable client interacts with a server that knows
>>>> nothing of AUTH_TLS.
>>>=20
>>> The patch completely broke the semantics of the header validation
>>> code.
>>=20
>> If that were truly the case, it's amazing that the client
>> has hobbled along for the past 14 months with no-one
>> noticing the breakage until now.
>>=20
>> Seriously, though, treating a bad verifier as garbage args
>> is not intuitive. If it's that critical there needs to be
>> a comment in the code explaining why.
>>=20
>=20
> It is necessary because of the peculiarities of RPCSEC_GSS and the
> session semantics it implements.
> See https://datatracker.ietf.org/doc/html/rfc2203#section-5.3.3.1 and
> in particular, the paragraph discussing retransmissions by the client.

Retrying is fine.

But the counter in the client is called "garbage_retries".
That's not what is going on the EACCES case, though the
behavior is close enough -- it's code re-use (good) without
appropriate documentation (bad).

The decoder treats EIO and EACCES exactly the same way.
Again, code reuse (good) without appropriate documentation
(bad).

I tried to address that in my RFC patch by adding a small
explanatory comment and by adding an API contract for
rpcauth_checkverf().


>>> There is no discussion about whether or not it needs to be
>>> reverted.
>>=20
>> The patch description is wrong, though, to exclude AUTH_TLS.
>>=20
>> The reverting patch description claims to be an exhaustive
>> list of all the cases, but it doesn't mention the AUTH_TLS
>> case at all.
>>=20
>>=20
>>> If the TLS code needs special treatment, then a separate patch is
>>> needed to fix tls_validate() to return something that can be caught
>>> by
>>> rpc_decode_header and interpreted differently to the EIO and EACCES
>>> error codes currently being returned by RPCSEC_GSS, AUTH_SYS and
>>> others.
>>=20
>> That could have been brought up when 0701214cd6e6 was first
>> posted for review. Interesting that the decoder currently
>> does not distinguish between EIO and EACCES.
>>=20
>> Thanks for the suggestion, I'll have a look.
>>=20
>=20
> Now that I look at it, I think your approach to satisfying RFC9289 is
> not correct.

I'm not following what aspect of the implementation is problematic.
I'm going to assume you mean the implementation of opportunism.


> Since this is a transport level issue, why should we not just mark the
> xprt for disconnection, and then retry? It is entirely possible that
> some load balancer/floating IP has just moved the connection to some
> node that was not expecting to do TLS.

Depending on the security policy chosen by the client's administrator,
that could either be a security problem or a "don't care" situation.

If the administrator wants the client to _require_ TLS, then
connecting to a load balancer where TLS suddenly becomes unavailable
after a reconnect is a hard error. This prevents STRIPTLS attacks.
That's good security.

If the administrator wants to allow operation to continue even if TLS
is not available, then the client can recover by not using TLS. That's
rather terrible security, but can be desirable to improve backward
compatibility.


> The only case where that should
> not be assumed is the case where the error happens right at the very
> beginning of the mount, when disconnecting should normally suffice to
> trigger the RPC_TASK_SOFTCONN code anyway.

If TLS goes away after a reconnect, that's a problem. Whether
further operation should stop depends on the administrator's
chosen security policy.

The security policies are NFS-level settings (eg, mount options).
RPC just indicates to NFS whether the traffic is protected or not.

When NFS asks RPC to ensure the communication channel is protected,
that means every reconnect is protected. Communication with that
security policy cannot happen without protection.

Trust me, the security community will have it no other way.

If you need opportunism in this case, then I can add back the
"xprtsec=3Dauto" mount option, which you asked me to remove a while
back.


>>>>> In the second case, there are again 2 subcases:
>>>>>=20
>>>>> a) The GSS context expires, in which case gss_validate() will
>>>>> force
>>>>> a
>>>>>   new context negotiation on retry by invalidating the cred.
>>>>> b) The sequence number check failed because an RPC call timed
>>>>> out,
>>>>> and
>>>>>   the client retransmitted the request using a new sequence
>>>>> number,
>>>>>   as required by RFC2203.
>>>>>=20
>>>>> In neither subcase is this a fatal error.
>>>>>=20
>>>>> Reported-by: Russell Cattelan <cattelan@thebarn.com>
>>>>> Fixes: 0701214cd6e6 ("SUNRPC: Fail faster on bad verifier")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Trond Myklebust
>>>>> <trond.myklebust@hammerspace.com>
>>>>> ---
>>>>> net/sunrpc/clnt.c | 2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>=20
>>>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>>>> index 12c46e129db8..5a7de7e55548 100644
>>>>> --- a/net/sunrpc/clnt.c
>>>>> +++ b/net/sunrpc/clnt.c
>>>>> @@ -2724,7 +2724,7 @@ rpc_decode_header(struct rpc_task *task,
>>>>> struct xdr_stream *xdr)
>>>>>=20
>>>>> out_verifier:
>>>>> trace_rpc_bad_verifier(task);
>>>>> - goto out_err;
>>>>> + goto out_garbage;
>>>>>=20
>>>>> out_msg_denied:
>>>>> error =3D -EACCES;
>>>>> --=20
>>>>> 2.41.0
>>>>>=20
>>>>=20
>>>> --
>>>> Chuck Lever
>>>>=20
>>>>=20
>>>=20
>>> --=20
>>> Trond Myklebust
>>> Linux NFS client maintainer, Hammerspace
>>> trond.myklebust@hammerspace.com
>>=20
>>=20
>> --
>> Chuck Lever


--
Chuck Lever


