Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5308D5E6629
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 16:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIVOun (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 10:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIVOul (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 10:50:41 -0400
Received: from mx0a-0002ee02.pphosted.com (mx0a-0002ee02.pphosted.com [205.220.167.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21838895E9
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 07:50:39 -0700 (PDT)
Received: from pps.filterd (m0270672.ppops.net [127.0.0.1])
        by mx0b-0002ee02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MBpdhS012155;
        Thu, 22 Sep 2022 09:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fedex.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtp-out;
 bh=LReXK43orqdKJ29AqxBkwpx+d2xJXeihgmQ1xmOPPXQ=;
 b=QH4Z+gyL/mgDINfwpEie17RfVksZHcT7vTOthnAbwNjp0OaDxx1JPkQ9J/Crv8qj66EP
 shUsV4f0FqtmI9JiwsCk2wKt6iUzXjFCjtInO9/i1wzWeD1pTezuh4b55DH116x+AGGk
 TLpFQS4HQa/MRbVLJzUS+aevSG4TbeVzdH1V8nmpsgv56xBqmiVxXhzE732atlzX3QVD
 AnkVpekdsV0enahlWHs10oH+miwnYCZbgefoDjw3Ggb5PPpqqvXKsIYLFODEFlkNAUMi
 sTq6Et/y292ROz6L6M+sFpiO1gRBOOYeXfQX7d5fdkeCdrxX/8jV0QgZcyPJR5jCg4aJ 1A== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0b-0002ee02.pphosted.com (PPS) with ESMTPS id 3jrq6ujdrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 09:50:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eepP1njAruQd13GohwnV0usnFkC0bTmLebqC2/TijE5VM8ptDDOH9S8AlktuDUrgQE1lXBpjTg5WnsJ1qF2OHc0CKT3NdvcPKKKfk6dvDudQccjdBEptFcORdtWR2aEqxFYsAbznL2kk9tXSKEUlcj6ZZ/JjRtd/0z18he6+m9SzVzPqeE1+dIj4A/IU9nItzzlDfCdZ7AlrfsidTxIkjkf1PToNLaapcbNJPRSG2Fj8aeMiQS4cxv3t2Dyd+H1PnPUIq8T6EYqe7WWDLh7dIWpYRXI5xZAfQ/He6BGFI0NyrsAy86/nU5UnU6gIJRo1nNsVPo7YqKMW4ugJM9Db0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LReXK43orqdKJ29AqxBkwpx+d2xJXeihgmQ1xmOPPXQ=;
 b=YeDJhcidH/YteqiEJxXaweW2ZnILmaCuOf+bkpAvlP+FdEp6QPJd7HeRgyOx2bQ5llrZ60KyqrIPjcl+AJF9j0BImeLf//TE3p20UDB28IhXLjDn4hk492kLiWyXDftYv0cfxZoWHIXwk0LsXUFu9lkHnMfzqFPZWpqjmesvKqXx9TRfNoTd9/6V1KUxWmkCrYsUzj+OlEH2FC5vTVgpxFC/BJCe45CMwEyJPUnywW7RTBZ8QsGDI6475YFEZcQTgfBGBEKducqVRAGz1qPW9NPgfqL8kiidRisEua9zXtrd++qHWYn/fPhKsVp0xZtrUaZxsescLiRvIPms8mCTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fedex.com; dmarc=pass action=none header.from=fedex.com;
 dkim=pass header.d=fedex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=myfedex.onmicrosoft.com; s=selector1-myfedex-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LReXK43orqdKJ29AqxBkwpx+d2xJXeihgmQ1xmOPPXQ=;
 b=0xgLep5avYfBgCKyaPu269tmpQ/d/nVCiuTHP+tMDjAqxrN+auKxM0lDOTaJYhjLpz3BkQ8ELuCrQ4x/I1FmQeAA1NVbz/rwTTzg0xl0P4Y3viet3ui8l/4lQ+EEoLLcC64o/qF1l78ahhl3asAteIETPZ8DaSG1SHygiEH3+n8=
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.19; Thu, 22 Sep 2022 14:50:03 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::f182:c1ec:d17d:43fa]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::f182:c1ec:d17d:43fa%7]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 14:50:03 +0000
From:   Alan Maxwell <amaxwell@fedex.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: [EXTERNAL] nfsv4 client idmapper issue
Thread-Topic: [EXTERNAL] nfsv4 client idmapper issue
Thread-Index: AQHYzoyLB0ZCEFrXiEO+WVUdCpVZ7K3rfeBggAAHfgCAAAJzcA==
Date:   Thu, 22 Sep 2022 14:50:03 +0000
Message-ID: <DS0PR12MB6486A843F54547C497E6064AC84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
References: <DS0PR12MB6486987EC76AD88C7A80D229C84F9@DS0PR12MB6486.namprd12.prod.outlook.com>
 <46FAEBBD-50BC-464B-A983-1DC2232795C5@redhat.com>
 <DS0PR12MB6486B941F1EA96D2634CED63C84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
 <812A1C59-B489-4D6B-8673-15F5C86A99D0@redhat.com>
 <DS0PR12MB648637C3D4E07C6FCA90A0E4C84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
 <CA53F1A0-807D-4297-9E1E-75E4AA26D470@redhat.com>
In-Reply-To: <CA53F1A0-807D-4297-9E1E-75E4AA26D470@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6486:EE_|CO6PR12MB5460:EE_
x-ms-office365-filtering-correlation-id: 459e2d15-1e8e-4f23-1179-08da9ca9bb83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fudEDoq5dSpHsqy7jT0WW2KIMaec8hSf4xjUGAKqGAT5yWqJKJwemDz7kkEHZnCLfN88yTHvAyL/yzvJssnK2gVNqrqqYbV5O+CrsvbjtO7iNabBWpJWlk6Rus7nOiGwQbSzVgpEZP9/XySJkWzmGmgozzHMwawsAkMWHk+LWoTJop6p4GILtuVz3Xk+dUXVrVy4eEqnMQVC9i6t6PlJExCatthL4pDY/nqK0b5B+1InyxcQAXyXW3FOnuBkJFNSYQQPaEdfWCAIWwl9vUWwA+Sfllfgsbl5xyshT92jYq8a0XD3iozWjWTitJ56x6TX/yTFKoxO1ufpQoAaZSikrPQzqhAMTcpRWhfm4lh13UleGrRTWbvG0JbQWoqYY1zVCgVgZMaoS1fo0Tlzb8iskdspP9ImR1KV5d324HR9D84e945AvEirXTgQg2M8dQondDjUzCDRt2YQ0zUXlVgoOqRnq/SXckehpGwrvM2GdV74O5jIvokOCPV4GPDfJ4xaIY6H+Lw4UPCIB31awLb3qi5E7LAyeGPpXgUIBlLyvkOwxMO3cxA7DvysPYP2SZamCclg0MLX6KdrVTKtuUnaUhiktA44QU5oUEjCbg6ML+jPDm4UW1dJWz2JWrKbgeiJhP9CcPzzAv2kSOldkTIPIa8+o8pEUr6sdpPTGkw1OOCWyHBxBavi+yOo6TSkMVIXVYzn/iS6o0mwXumU9h+9OdLVmCB5DXMpraTLUtFiFZ1/R5fsNQsaqrZ3k7szJGjBQwlwhK3O62sGBB0TnoFfMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(38100700002)(82960400001)(38070700005)(122000001)(86362001)(33656002)(83380400001)(55016003)(2906002)(478600001)(41300700001)(53546011)(7696005)(9686003)(6506007)(186003)(26005)(71200400001)(10290500003)(6916009)(316002)(76116006)(5660300002)(66946007)(52536014)(8936002)(66476007)(66446008)(64756008)(8676002)(66556008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R/P4GZFcCsYmujduXTk69tZrGXkqDY32C6t4eRwGy6uZGK/fZaRaY++FzlbS?=
 =?us-ascii?Q?h33zO7o1+fVPMbHXm8T/r7m67FzcgRVtAMHNK1lhD6I0BTakE4ZLV4HtmzhR?=
 =?us-ascii?Q?yxHuE6m+BVLRBKV3QoaqXDYpnlxPymv09gao7z0eD+ILD8/rxMfauXdYaHVa?=
 =?us-ascii?Q?GHUj/uiZA59bB7N8FJjSmFnF/BQAxcpUo/X9AqeOn+BtUoQaN40EpccqVX6q?=
 =?us-ascii?Q?fZzPe9XZ0+MRSJ4f4ASyWRHRlP1xXCGGBGtJxIY0O+8mHpQ5AZzsLMjUZKhr?=
 =?us-ascii?Q?Z+qHVkFDj4u/DSrF1EDP1LofRi1ox17vOkvOA5V5tXvXhwFW4BAZgA8FWxj3?=
 =?us-ascii?Q?QDGLG4wk8Soj4ef1zkko9ID/9zVsijwiuz2myup51Yr4xppqYB4xzBVkxuOc?=
 =?us-ascii?Q?bvluKNkrwgHGaMFOeFaMEBMUk0bay6SGwJhAKUbzepVrfcLO142es49OVzPr?=
 =?us-ascii?Q?E/eJUo8Oam2zUDVCWJ1FP4QeQxypsRaLmO389SUnOlIGqxUxebF/xMMpMX+7?=
 =?us-ascii?Q?jVDol47zfixyfnoBFOvDXWDYKffjp15A9xf0DuoQuWwsJ8IVauxYTseAeN0d?=
 =?us-ascii?Q?9ruXlxYdeNuxe1WMBBfjLG/hCMcXEWnOnhks0/2/tlcuWht39PmHBKT1LM4N?=
 =?us-ascii?Q?CHDWshrwhqyaBGFKTN1YBjsuaQ5uaTWDDg5F1TaDJeOoeiK71gXIUcct5QsY?=
 =?us-ascii?Q?4DbHh2VV2hSdaPZAwmucH05Zzp98uLg/hmjDBdkfOiqz8xw8cu9N1IZ4eL75?=
 =?us-ascii?Q?IleS9mpIYmTNSY19nJW5tC4TjZoOUuuPrfndnD2PgVtE3zgxKI3pKiAxVyQO?=
 =?us-ascii?Q?zpPoAGknIeM2H79nziMxeF5ERDuzFMHie+RApQTrB35e08uGWaiOrUGLnjOq?=
 =?us-ascii?Q?F3QTPVFbf5PcWkKwFVI5TGHdyKrji9zX19g7GCJ+8KQe9jY3aSLaoPouoZw/?=
 =?us-ascii?Q?OabvkhRyicRbjb2uckpTtbK+zkM5Ol9YR7SHjHZdquflywETh7+GLK5dhaOA?=
 =?us-ascii?Q?Vlf1TCyo8HEgAJQ3ghR7H6H4E82QmRBkl86cKoDULtK5chtgAKEMQoCwT5n1?=
 =?us-ascii?Q?zyBOGvnt/Wne1syBFVy9vM2Z6chl9XIiZgcRxHi/0dELq9e3yA1W16MB92We?=
 =?us-ascii?Q?X7FTYvXkXur0AIDGdJrBMAd7QMUgxjQfJyWK5M3FzkBA6gHjKDJLXj/H9A17?=
 =?us-ascii?Q?hqU2TqwBUp+CcjpG4gDU5zNqXE88YtWb12SIL4SqqJIVgpZKqk9ps7RBf9eB?=
 =?us-ascii?Q?Ruuwi0ls7WVwKfKf5DlgLHX5Ru+8swGG42Lix9gIM0OI710jmhufS1qcaFN2?=
 =?us-ascii?Q?HDDVT/kGXQYedbPqqa7BcHrZlvVbiPGBdFC7ye9xCZ8MtLg7FJx7GMTSHTEX?=
 =?us-ascii?Q?JI2kCNfWZz2Nq1TRhIqjz6uExEOBhWHlfv7IfvKlEnZJABg0Fop8fpySF8n3?=
 =?us-ascii?Q?l45QLr+l5rgP5Jnvqry0jd6I7Tjp4OvetB/KCmWncXlm6i3ThrKmlxCWj1oV?=
 =?us-ascii?Q?ub0FrT0CXxjyZMICfARNkdedyfUjjTRWyOtH3uIlc8tkdJsjdBgLO3vcT2OJ?=
 =?us-ascii?Q?J53QeXw3EOllKlRkiKYlHapvSnd5nR1fylG0pAUN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fedex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459e2d15-1e8e-4f23-1179-08da9ca9bb83
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 14:50:03.5525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b945c813-dce6-41f8-8457-5a12c2fe15bf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QnprG4X4Bl4Nb6XdMzqWDo4GNT0z+7w3z4aeBCjI7lRk+G625bIzZt7ziRVHAgwiAkluzV8yXBTPUpRSuBtKbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
X-Proofpoint-ORIG-GUID: kioAoxnUQVjSocjaPahHR-8-0BcuxU3j
X-Proofpoint-GUID: kioAoxnUQVjSocjaPahHR-8-0BcuxU3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209220099
X-Spam-Status: No, score=-18.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



-----Original Message-----
From: Benjamin Coddington <bcodding@redhat.com>=20
Sent: Thursday, September 22, 2022 9:40 AM
To: Alan Maxwell <amaxwell@fedex.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [EXTERNAL] nfsv4 client idmapper issue

On 22 Sep 2022, at 10:18, Alan Maxwell wrote:

> Again, we would expect ultimately if the server returns error, nfs=20
> client should do same, show and error, not change the configuration=20
> and ignore our disable_id_mapping.

Not all NFSv4 errors are sent back to userspace, and the meaning of this er=
ror ( I am assuming the server returns NFS4ERR_BADOWNER, a wire capture wou=
ld verify it ) is to tell the client that it was unable to translate the ow=
ner value.  As I understand RFC 8881, that's a clear indication to the clie=
nt that the server is not treating the values as numeric uid/gid, it is att=
empting to map them.  That is why the client changes its behavior.

Besides, what error can the chown syscall possibly return in this case?
Let's say the client /doesn't/ re-enable string-based names. What are you e=
xpecting the client to return to userspace?

I would expect chgrp to behave similar to a local file system:
chgrp badgroupname junk
chgrp: invalid group: 'badgroupname'




Ben

