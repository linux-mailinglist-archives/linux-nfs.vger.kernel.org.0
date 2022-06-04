Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5724553D78B
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jun 2022 17:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbiFDPoQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Jun 2022 11:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbiFDPoP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 4 Jun 2022 11:44:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995F519C34
        for <linux-nfs@vger.kernel.org>; Sat,  4 Jun 2022 08:44:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 254EdGcq018543;
        Sat, 4 Jun 2022 15:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QskvyZ5mpBD7MjhtpXa/OfxJVNdK9EgbjbWDyhe2tPM=;
 b=JRQ2cYQfwh2PGv6IX5Jxk/hizXGm52ELqXHhxjET3nQpUsfP6rxe5ZXsEjwuxUC6CUIc
 XZVr20nMlKVHaeqXsP4aBEXNP5dO6F8IVNjTgcpRSgKJrw+HeVWMe4NatjCcvtVOkzUC
 ldpD0no0qIJVR93rpKp6UzLfUw2/1kJ3RlrN5XensnjqemVL4urijx8MwlblsA6NaOne
 tr2yB6TRtaCnKrHQcDxdzN8CPJJDdFPR4BfAH7/+jXDwukqjnHz/YDYS3LHNStwg+/lJ
 tGeE0efd3qdZda06/1jY5n1LrSSOd6PPXs6JH6yLQPpiuCaZR7y6A6y61GAAqxgXddqn ZA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gg91101fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Jun 2022 15:44:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 254FVJer003592;
        Sat, 4 Jun 2022 15:44:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu794xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Jun 2022 15:44:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJY9racqay5ePqWQtOwOwCJTqPtRLJZqWSnZVxT8R4jX/UAjciPq2MD0xRnvPOcBHzh2Dviqu3c7d/hMbcyhivcFySFy7QGoqiWP0o8lW0nYAjW3TDNMwZs2C8LAne9h78/oFneyWkoMt46ACZJX+OFHix62B5PGC4hkNkVQN3q/ahOAEJ5WCnqVVRN261NmzAIn31gs+6sHlkFQbWqnZnb5hTj1dsrWQSafJGjPajTMr3q/ABLeLzTauD30JJWZEOEpQTApuB/7p6bP2JQ5V5tYITGezxGY8uovVDjJ+MJTBKa/b0qapLTcKx5VRFCFUFUcL2k/tL/aQY7DxrzEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QskvyZ5mpBD7MjhtpXa/OfxJVNdK9EgbjbWDyhe2tPM=;
 b=gmYDMeeQJrcm5Cdzt6Bs+f2OtIvYxv8fYkE3da11jV4t7l6J/zYR9h8aqRhqasM8r5ujqXTFtGrYOuwVDKBL0MO0tP04+RxYr5gUQXbFsU2my1Zyj+THZLwsZhx4jFnoepLhep8LLKnbDeMEpoDYciIfnJF2fhv1XCJgQjlWHpTnZXSnd2c3VjxfBpJjvSGB2CSjZcfB5A8Kg6ecqmWyivgP+1E5e2WXBb6WTc+Ekf/i03KbnQmiA47A51WZAGxB8etODMkoi1CznE4JyYfZseO+IoKKfq7figDVRnRP1GF9XV8NGz0YD4svVlIh2kBQh2IOE+dKPTchrHKzEBg/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QskvyZ5mpBD7MjhtpXa/OfxJVNdK9EgbjbWDyhe2tPM=;
 b=S5XbovPkE7GFvrXvoPGEaXpnRcuKgt2JbfbeCIuWG6a6R2WaPGG3KhQSIrumSud1gHrQiLG1NqD9YFZD3ikKXXqAY2SOzTQbUE1uVMCNAYCzcmbLoau9aUcdrgQtp6p9ohhqYqfB4LuA/SeC9sLP3hji7N0bVuog+MVOgLy9wLA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN7PR10MB2692.namprd10.prod.outlook.com (2603:10b6:406:c5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Sat, 4 Jun
 2022 15:44:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5314.017; Sat, 4 Jun 2022
 15:44:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
CC:     Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: filecache LRU performance regression
Thread-Topic: filecache LRU performance regression
Thread-Index: AQHYcfvwqM9TwnG0lkutiJn4EA8Bxq0zLyiAgAAP6gCABnuxAIABBV+AgAAHvgCAAJpHgIAEDbiA
Date:   Sat, 4 Jun 2022 15:44:05 +0000
Message-ID: <1D00FCD4-8EFE-4080-A706-61FD7886CA52@oracle.com>
References: <20220601161003.GA20483@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
 <4C14DB3A-A5C1-41A9-8293-DF4FC2459600@oracle.com>
 <20220602094956.A396.409509F4@e16-tech.com>
In-Reply-To: <20220602094956.A396.409509F4@e16-tech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 603061ad-d706-49d8-dfc1-08da46410eb4
x-ms-traffictypediagnostic: BN7PR10MB2692:EE_
x-microsoft-antispam-prvs: <BN7PR10MB26923AC7B4E85F1C4F902AD393A09@BN7PR10MB2692.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TuJxeI+6I0i4GQ9uFpnAtqzyAgN0oO0nnGt7Ggozg6ccEe9pQ1D6ZMzMVTk7JSTnJrYM7UcztL3EsSZFUWO2AfqkIu+sAMVS7ySmTPbm6KE/LnnQnJY/riYJkKRJ5bfUcK8xWk5venT0EQifTfVZLdrWa6wHVGDENTvZRCeB6ZSnO5/U0CnngDf9fEm0EOHQx1qDX0zIpZcbCBO/+yiaNgu/0IRP37lxgpRLN0g3DuLPPYdmq0SzFrENYA5/niL23ss8NeiLrt1+aRH5HQrOz1fhUMGhL2/Oiu91qUxYKsMGccyJE/GfZw/+OwpRz725cooE8Z9C3YocY3ZaxO+pajWVifjXFSF9hsXP0Q1whx/+6N6/7Etb7APmkgwwoeYPtCKVziPd6qRdDl/WwlpF+862ZQovebItv301luVijKl1qSW09RfDkIi0BLNDIwRv0MXhgyeFtYcJvSc7SIGmRlVMHzTxvi57eGlze0Vo/b3WqoOJHGSwrTXHKaaR82AZGUG/zzUZs9L29U/qjfADccqrBEanWf7WB5FuUyDnkqbpaAICloy+dtS8eGd71+4RLpGlzFII3ZChYl+YOwaOIV1SU2H4JdibhwAqPgrCSUXlaixEs3ZhJuM1wNgaJGaCKuE/7lo8eyYE4SG1FUwqFYF8z2X0iKCEU5XhcYqwsHSt6X/c8faFbqYZWKX80+SKIsnJn4bGgHI82s1zQoU487VnN0eDJEcWUGrwSfK0U8oZChckBCmAkTod1V0icwRPjlHaFi0935E7FKJzVr/+NtFR92s0ktB76LFfPEHR7NgFvjCj1u0JUX+3YwE4aJ9AhomH5wmkMiEA8cbR10C0Qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(6512007)(2616005)(38070700005)(107886003)(8936002)(122000001)(33656002)(83380400001)(8676002)(6486002)(966005)(508600001)(5660300002)(2906002)(4744005)(64756008)(66556008)(26005)(66946007)(186003)(66446008)(6506007)(3480700007)(36756003)(6916009)(71200400001)(54906003)(38100700002)(91956017)(53546011)(76116006)(86362001)(316002)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2vgklmQVTxbDDEC0H/oHhz6G4n2Jx30Lsh1zcmNUNIos5Jvwh7KgCJW0iJ4j?=
 =?us-ascii?Q?95UJfPW8l2DZxWz9KVKbqeWSlD1UyK8cRY9NC0T0BcNcBq5+9TrJ1Vvq3y8o?=
 =?us-ascii?Q?g7SYExd9PQL0TB2ydZoM6La7g9ATt9FX+5Wgzk4o6Ez2yI6JANSC1e7Nyc+L?=
 =?us-ascii?Q?ocZfB9a2b8AHYvtgPboAfxUU8RZlr6NZjbKG3NAAiwjR1AoudT6n61WEtgo0?=
 =?us-ascii?Q?qKeFTNr6AjG8BWSSTWRYALn3cQ21W1kwSt19gDXgtHsRL4gqei2g+U88pdiQ?=
 =?us-ascii?Q?s9JH1sNce635R3zNuka5KsVuf06Nd5bqsPjYAXQMS0iXN4HBaXNpkjzWqDB8?=
 =?us-ascii?Q?vsjeEMAR2re6S6AIXjthetZJSdjQSTDNCiUTBo+K718gf7SUORKy7i0/pHLO?=
 =?us-ascii?Q?IL/WYUHWgTzuBO3RWDLf+F8etoGWvZvBu7hXN9EL8CiwSsjZPPUowelShz8M?=
 =?us-ascii?Q?WAq6IPvQGM+5huEP1bbiUAQVN+wN6m8i4MgvGxVN4ggflRNlX3LccHTnYHEA?=
 =?us-ascii?Q?eTBAyJ70zjbbOH6PM8mKkYl5w2G4aWeMCn+rX+rtX5gKK/GydixT9DsMw+wl?=
 =?us-ascii?Q?i+/ue+kzg2Y0LEvkjAjadjSFgh4qR6S3bxEiM0ifbGPNy8WC4rBrZK5LTegi?=
 =?us-ascii?Q?GrObePRkSbmwelpMpNU8l8k+gukzZdGGyrg6T2D2Qcq6ln9b/x+Re+DVgnd6?=
 =?us-ascii?Q?rL6Cm5Lr/NYd4F3cTkhUVeZlAW5KcgtgmHiAXtcYYPse0hq5qUEayzOfoSJk?=
 =?us-ascii?Q?HBXsvOcxiVZcfUrhB6TULvKT2yKY8NFC+qMNFsNMRLaVk+InqHI+2fC6E8O7?=
 =?us-ascii?Q?BJYT4wYiqhclCLO2DuvGDuslFWQJWuM6ThxO/iN+RsUvcHYTKjdij1hR0KVU?=
 =?us-ascii?Q?8hT93CS/qIL5fK66IvVkDBPloEVqfi1YalvD3xjF6n1Gndbh9zlv+3wSrUT1?=
 =?us-ascii?Q?3U9H8dcVKjriEsKLzT5yYloQnxgE0YuzsoP2/C9v0azrt8NPAFxwxu/892Ni?=
 =?us-ascii?Q?PNggupPzuqn1KEevbOsaCkz9MavN2QSUBx0KOSvySv9PnPAFCbDv4fd0sWKB?=
 =?us-ascii?Q?0d1nKkdRyaqDSzL+57JTk++JEKWaZZWUCM/JVKj9OzxAD2aKgAF093vc0u0D?=
 =?us-ascii?Q?FcC9EugraX0qv4o4e6CR+90IGjb4EwFDV+COoSVi82OROKf8+U3xf7vJRIgq?=
 =?us-ascii?Q?8Pn+9RAHgod0iGiWDN6CCYAD2Pw9ORgxvfkx4WhnYtkl7TVPCf/UuFURYbQF?=
 =?us-ascii?Q?GGYgkCFtmO2x57deFI5YhfECAeap78d7Q4KiETsG7kmM7bKw8d4EDwdVADuC?=
 =?us-ascii?Q?6hRp18Ph5yo7Ve6BoE5Yn+EEruZU0zaRdlGzt89ubo0KWu+XZfNxtq+K3BmW?=
 =?us-ascii?Q?CrrPNaf5tNijP89Ec+SKT+8PfDYT+1YV+xG9UOLVdWMvozeM/hkJCTRU2k8X?=
 =?us-ascii?Q?ofnsPhKEbxQD+4YHCuhvuOEdE9QKkOX4OqJ9/3F4meVZD5me8lRyuMgLzdnH?=
 =?us-ascii?Q?vn/EyCbEAcS/ftjuzijeaEz2v62HW53WYjPzGcxDLIqdF40fb40doWEKe5Wn?=
 =?us-ascii?Q?sWFWjdJwzmK6VY8dlHNfaD/ma7EBj9xwOwY1FXHs8LBAZCsKcMgMHGmxDfLu?=
 =?us-ascii?Q?+G7eXjtuuFqm6YInvGZdcXBP5p7FgRprkLYwxXKUWpp6FoXzrSYy1vX8mljj?=
 =?us-ascii?Q?dwSscQF7cZSlD+NI2ECb4pjHa6iwxfzFhfUSEMQqg9DQvj5l7gZeRPSoWnoW?=
 =?us-ascii?Q?Kth1tltRyBSiJ2seZHZNlEOKxyBd4Qs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECF25890A3E83249B1C7386E22C6A449@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603061ad-d706-49d8-dfc1-08da46410eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2022 15:44:05.9431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtaywnVwsXS4+LjuRMwT6MwZm4ml/733IfYUoZy3FH0dykEHFzQ6AdJpFM+iR9d7Q3wyygj3z86RfnSRlpyxOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2692
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-04_04:2022-06-02,2022-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=915 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206040075
X-Proofpoint-GUID: hBBi9eVk6UnidH-yV2kIE-D8smuN_wvr
X-Proofpoint-ORIG-GUID: hBBi9eVk6UnidH-yV2kIE-D8smuN_wvr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jun 1, 2022, at 9:49 PM, Wang Yugui <wangyugui@e16-tech.com> wrote:
>=20
> Hi,
>=20
>> Certainly, though, the filecache plays somewhat different roles
>> for legacy NFS and NFSv4. I've been toying with the idea of
>> maintaining separate filecaches for NFSv3 and NFSv4, since
>> the garbage collection and shrinker rules are fundamentally
>> different for the two, and NFSv4 wants a file closed completely
>> (no lingering open) when it does a CLOSE or DELEGRETURN.
>=20
> if NFSv4 closed a file completely (no lingering open) when it does a
> CLOSE or DELEGRETURN,
> then the flowing problem seems to be fixed too.
> https://lore.kernel.org/linux-nfs/20211002111419.2C83.409509F4@e16-tech.c=
om/

I agree, that's probably related.

But let's document this issue as a separate bug, in case it
isn't actually as related as it looks like at first. Can you
open a bug report on bugzilla.linux-nfs.org? kernel/server

--
Chuck Lever



