Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E40360FA54
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 16:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbiJ0OXa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 10:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiJ0OX3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 10:23:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BFF7E810
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 07:23:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RDxPOW026776;
        Thu, 27 Oct 2022 14:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Cv7xp47SrkGYk1p5PIuLGsY5uTmYjXDyKFNzfck+9t0=;
 b=PtSDyJlP0YHthH9+lfBdR4kGA7LsSR7YWMUfX4SmsgOKqAhC7AwatfhImWu/E3KpPmVR
 n71zsmE//srPHKk1SHZweNvugJq3mhHxle6o5NHH58AHJzUqRlHZFrmJc/aXyRGiqyFU
 tPkkQWeHHpJFN3xZB6k/IG5VRwqI6m9fZaDhOPOaOXNGoRJHvpPsrj+s+Zg2+dAw6dGz
 IUua/g6t9LeKLOj882YfwcGTTel43fUpJg+zdqFI7axAO1eNK7EXk6OeCmmpHsF1SW0/
 F5tOzhwN2MBSONg+tGISfP7huwpJs6qHynn5Lz+6tMNyKrKCG6AdQBfwTUp8sNUZ3Tzg xg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfaheaevb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 14:23:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RCYbVj033387;
        Thu, 27 Oct 2022 14:23:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagn1kq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 14:23:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiREB92rPSygfWt46NUXBEimTaEsWZO61ld0SDpUm09abS0HAadBdbd6gpQ9o9XZFl2VmVqtb4rsHZGVm/rMIAdE2M99WJR3VecKzMFYOEAQnQWNryP3Wl2lD5Ds0lHT7ABErLAfA36aa+WxXPIP6bzm10IIO+vkE07Q/oLXvAPoLqgML2vPpx95nNDpQWSX39hY0Dgjl7wxA3er2/y6ZJ/g81TeKU3djb1MG/CoiBFXeBcmoFyVEkM6/D9r2UBkjJi6z5eH1m4cNgInMmmSWKBclWsWIQUI/ih3GildVp4dq9GBR4Ndciixj+Q6UcHv15+itqQSNeexToTIC2fwfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cv7xp47SrkGYk1p5PIuLGsY5uTmYjXDyKFNzfck+9t0=;
 b=LBTp/2IyblSrRFsga64VIE+FFXoKYAjKNjsKLOSnz4tlNRfVjM2l/gap6k8drYhY7woLSnJPswVO5/EjjyyUEC/LWeaaUgAYjQIeYpk2Rj9KrvAd//oSoBDfSoYpMYKodAkmE6cXx01/i+cx2T+3ubBoBHsfG6TFwxR0Q4ZCzGESi1Xadsh52vgfJhxa+dYGjzu/LTCYIMgHezqdOru50LIkyKMYp5tGvlbjtoA4HWr2TWbm94ZeI0OrzUQ9uhza9qj80ZyfMslsPxRHfvaeqjMumkmsqCMLL6+SDiYFqAWTQvR4njIzY85UfEUgNDU9y86a1JpoUDg/vi0Bdrt4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cv7xp47SrkGYk1p5PIuLGsY5uTmYjXDyKFNzfck+9t0=;
 b=K/g6zG31q0TVplF6cXemBZcI14bs7QEoU2U6iuIBb9gyQ0VIIfploSGYeki4R4RuWwy9pU48v+yZ3O3kCQBX8S5DhpxFm/7lOpiJcFyKKgAGYKvP6fnsBGf7+CLtrNrOYkWd7Kpx6NTykP3/1hKzDeyYnvjar+UkpRAyLJ1hUYE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5087.namprd10.prod.outlook.com (2603:10b6:5:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 14:23:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Thu, 27 Oct 2022
 14:23:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     David Disseldorp <ddiss@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] exportfs: use pr_debug for unreachable debug statements
Thread-Topic: [PATCH] exportfs: use pr_debug for unreachable debug statements
Thread-Index: AQHY5UgGkwnmp58/L0OX2xyj/M+Kj64cjjqAgAE8nYCAAFVLAIAENJmA
Date:   Thu, 27 Oct 2022 14:23:14 +0000
Message-ID: <1D5F6D51-DE1C-4486-8907-12B9993CCAB7@oracle.com>
References: <20221021122414.20555-1-ddiss@suse.de>
 <166656308707.12462.9861114416829680469@noble.neil.brown.name>
 <000A2614-4C72-444A-A1D3-7B259D99C70A@oracle.com>
 <166664939677.12462.18426253960350585268@noble.neil.brown.name>
In-Reply-To: <166664939677.12462.18426253960350585268@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5087:EE_
x-ms-office365-filtering-correlation-id: 4fe050eb-e1db-449a-d682-08dab826c90c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: izhD3KaqBOSTgo5vlJmFfXlpzqPNtJHpN0dm6XpqGEv65vmuXMzzRgl7Gd46OGl6W5HEjqQTBCfM+/LT2oIdwfM9e4Ewf+YJkPsumClSLe8U0OfXYGWvfhQhNpkKa3ILJwpDTQ0ibs+s7d2rJ3CYYmi81akQs5T/Bxx75V2Urw0ynsuCynvLEuSXg2GPwmOqRqHin4FL45R8RTCkF44QE64ZpWjef4q4uWr/E0lFHaJeQHSkE5CAKTJ7TDzRZaG/N6An3aAs/uwr+f+HSdwNbXTrWospxLQLktOyK1xYjyoxQGba/S6CjoDou8F+5CH6t1ayEHaQszs8/lXBWmc6l7c06un8gX1yhroZU/lRCYoSK0T2sO9sMFMiX+DwdfZJ5UMoolPQtBvWG8jdrdBUdSR9BQyxy40IUq1kRPClgu7znlTt5fWcw7/0jewrwkxgUoKNERKXRbnQLmWNR+tqS1G5+Ulx2MaKdHlKOKQMQzWtdudbSDUP9aTbyMTCdy7SD3PPvKbzf0tv18LU24q972V0fKFtv26tV1JzVNqXBPbuvC7lZUUtwGTwNh7fz5kG7sjheFfva4uyYBngjhTC4z/3BOXoyOEr/UOvA9LYOIxzZ7OSqyw47xv2a9EupqEWuCE6BG7U/xM74wgjI6td0KzF5B293QB2kFKawQUKlEm082c4MiNafkwubOPHR4TJj8ZAf8BytauBptHt5RmAePvHqHw4hClNPJiqT8nT4IWjmKaPxN2vG1ZZUNbLx6kDch5xUlBRWWp4+onDQOhkCtAnGyU+lPcYgwfc3qh+ED0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199015)(2616005)(26005)(6506007)(186003)(8676002)(53546011)(83380400001)(2906002)(5660300002)(8936002)(6512007)(4326008)(91956017)(6916009)(54906003)(66946007)(66556008)(64756008)(76116006)(316002)(71200400001)(41300700001)(66476007)(6486002)(478600001)(66446008)(33656002)(36756003)(86362001)(122000001)(38100700002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6NdsQGGmilcLKOq3gAeS9FZWuhg+9X6hUI+AE4ywwksAnmp2L7UwqLVsx/nJ?=
 =?us-ascii?Q?qntKNgbo/6CkDYFqgujau64YgW5y//BYCwUN/QOmsy8QPPotda+thUNsdwNt?=
 =?us-ascii?Q?f1kfS5bD0srvFePB/8lZ0fg8tlSA1etf6CjRvSm+pC0Y73rwWMm/LeylyO72?=
 =?us-ascii?Q?D0uIg4Y6LkMBaoSUZemFWK71IAdccztIfAQmFjMEiXWF7yanv40mSCXkCUUC?=
 =?us-ascii?Q?NGjEEtECwWlW4CuScP+jZkIg0YZYDwvrknEUlq5rdLrWCyNXnJFZ/r3j8uuX?=
 =?us-ascii?Q?ug4wkx8kXuDeM2E6L+7w7JH5bSChBee05amlr//z90geLE2830PaLF8j+NSq?=
 =?us-ascii?Q?xY7WtwFoWqjTz4HK91tJrm0phPtzhjprojh39CaQgX0JL2Xk4HBw9fVOz6o6?=
 =?us-ascii?Q?aFV5Pz2UdLXGoTkjW4Ry3oSuqeUCrnCnWKifr9eDMalWmpsE3LwIIgxxtqKa?=
 =?us-ascii?Q?O83Tizf3cfhp9njmS5BAUV2PuJRpw8yhr0mSppgA7HeaML3kvzP/nrO+kFYC?=
 =?us-ascii?Q?0/NlquQtiwte+8q48N7WNRtxd2bRA4Q1WS/0Cu1f6r3aBjXZvUWsdyf2/art?=
 =?us-ascii?Q?/KW6cRZP1+3HuR59gzkk1qfdJ1E/QaHwdbnnYoaAct9+zjbfd26+rEbhwg0x?=
 =?us-ascii?Q?ZPHOWinBAg/NQNlrNEgrLeh39EJq7xzH9NTsX1FkCISnzm3FV2OzPFjXd2o0?=
 =?us-ascii?Q?3K0qJqh5tkLT2x+ivf4zqDcFIP6MBbmKLuHzVrRaMMbUWH5t0AM1WCyn8wCl?=
 =?us-ascii?Q?tyywtOpBQJvxwG6H4efLBdbU/zTXFM77n+eyIYkDKA/5J+hv/RAV5P9LA4Rx?=
 =?us-ascii?Q?pom9Mqci4VPB7FaW255QX0L/ZSoYyv2oSsX/hEZiUrw135kDOTA1J/T9wP4z?=
 =?us-ascii?Q?YapAtmLirA/oXGVJm7esePuZowNcHhfVWzX4mbmQmOely5lKGdQUn5GfURvI?=
 =?us-ascii?Q?basHMsMHL6X6yhsvwYH/lT2zRP28Ea66F2x0RnNp5Fs09uB4svf9cjjWjjA3?=
 =?us-ascii?Q?h7rE9gb0NuoTwqMWRQSMKWhTQw3AHtDys+e9rvoKj08NIukxsPtZE0ZbXhGS?=
 =?us-ascii?Q?RPtcEZXT5RAuiYC8OIdqh6qKL0C/n42/axtxVxcIUww4KvWSN6b7UoRl3xHF?=
 =?us-ascii?Q?99X9BeTuxgEboxar5W9caxvb2vgUbzv4uoGAUujOUGl6GiYVvgy4/3aJAqHw?=
 =?us-ascii?Q?vOrrA42Aqyj0OCZaUk5Npk38rAuZUGkinc/UEBy/a2S+3A3/8RYNhOK4HklD?=
 =?us-ascii?Q?tB11B+Bi/9HrXOhqZ5kqQtTlaLgCqcZsA8/hQOzmnKZ027K/DYIHC3PLTsqW?=
 =?us-ascii?Q?S4Mqa+h5fWIc6gQaEMzG9IrvDCnH8PhFiEihLayrxfpj3ILV0SIoQNvO9BY2?=
 =?us-ascii?Q?CG9V1650Nx9zfKFcrWR+tqIFEdCuixtamiQu7TkeE9c63MTRF2IfRpM5p/d+?=
 =?us-ascii?Q?WphKC/SZ0sdism2Cp3Bv0+H6exqVoUBKhcR6wMN5Ob3NC0ZpgM7Jul3GAGWp?=
 =?us-ascii?Q?VhG49HYlAwIab57Vgj3FbwKmtjgNKOxwNGT6DLXy1kEh8MwN42HTfUZKG6XG?=
 =?us-ascii?Q?tre2YwgNNuNX0tsU0slKtnjRVGioDgul+gvjBfwM+5Q0pO/WUtKC99x5gnOX?=
 =?us-ascii?Q?QA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <91DA2B81512DC84DB1BC0296CACBC9D7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe050eb-e1db-449a-d682-08dab826c90c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 14:23:14.7051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rg3zw5kbHiNcV0wcOebKqruTOCKCuX5HN+x9KcYTZpPhqk2J8C9TjXGma9vxH4wJ2sc1kUhsgkp0hjQjI4Rvag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270078
X-Proofpoint-GUID: _p95on3-wb_EbAg0O2w2sP_KbUU-YDJz
X-Proofpoint-ORIG-GUID: _p95on3-wb_EbAg0O2w2sP_KbUU-YDJz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 24, 2022, at 6:09 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 25 Oct 2022, Chuck Lever III wrote:
>>=20
>>> On Oct 23, 2022, at 6:11 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Fri, 21 Oct 2022, David Disseldorp wrote:
>>>> expfs.c has a bunch of dprintk statements which are unusable due to:
>>>> #define dprintk(fmt, args...) do{}while(0)
>>>> Use pr_debug so that they can be enabled dynamically.
>>>> Also make some minor changes to the debug statements to fix some
>>>> incorrect types, and remove __func__ which can be handled by dynamic
>>>> debug separately.
>>>>=20
>>>> Signed-off-by: David Disseldorp <ddiss@suse.de>
>>>=20
>>> Reviewed-by: NeilBrown <neilb@suse.de>
>>>=20
>>> Thanks,
>>> NeilBrown
>>=20
>> I don't think we're the maintainers of expfs.c ?
>>=20
>> $ scripts/get_maintainer.pl fs/exportfs/expfs.c
>> Christian Brauner <brauner@kernel.org> (commit_signer:2/2=3D100%,authore=
d:1/2=3D50%,added_lines:3/6=3D50%,removed_lines:2/6=3D33%)
>> Al Viro <viro@zeniv.linux.org.uk> (commit_signer:1/2=3D50%,authored:1/2=
=3D50%,added_lines:3/6=3D50%,removed_lines:4/6=3D67%)
>> Miklos Szeredi <mszeredi@redhat.com> (commit_signer:1/2=3D50%)
>> Amir Goldstein <amir73il@gmail.com> (commit_signer:1/2=3D50%)
>> linux-kernel@vger.kernel.org (open list)
>>=20
>> But maybe MAINTAINERS needs to be fixed. There's no entry
>> there for fs/exportfs.
>=20
> Looking at recent commits, patches come in through multiple different
> trees.
> nfsd certainly has an interest in expfs.c.  The only other user is
> name_to_handle/open_by_handle API.
> I see it as primarily nfsd functionality which is useful enough to be
> exported directly to user-space.
> (It was created by me when I was nfsd maintainer - does that count?)

I can mechanically take the patch through nfsd if no-one objects.
My concern now is that it gets proper review. It's not an area
I'm especially familiar with.


> So I would support the suggestion of updating MAINTAINERS to include
> fs/exportfs/ in the NFSD section.

No problem with that, if my co-maintainer agrees.


> Having said that - given your apparent preference of tracepoints for
> tracing in nfsd - I suspect you might ask for a somewhat different patch
> :-)

I've certainly had that thought, but I don't think there currently is
a trace subsystem defined for exportfs.


> Thanks,
> NeilBrown
>=20
>=20
>>=20
>>=20
>>>> ---
>>>> fs/exportfs/expfs.c | 8 ++++----
>>>> 1 file changed, 4 insertions(+), 4 deletions(-)
>>>>=20
>>>> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
>>>> index c648a493faf23..3204bd33e4e8a 100644
>>>> --- a/fs/exportfs/expfs.c
>>>> +++ b/fs/exportfs/expfs.c
>>>> @@ -18,7 +18,7 @@
>>>> #include <linux/sched.h>
>>>> #include <linux/cred.h>
>>>>=20
>>>> -#define dprintk(fmt, args...) do{}while(0)
>>>> +#define dprintk(fmt, args...) pr_debug(fmt, ##args)
>>>>=20
>>>>=20
>>>> static int get_name(const struct path *path, char *name, struct dentry=
 *child);
>>>> @@ -132,8 +132,8 @@ static struct dentry *reconnect_one(struct vfsmoun=
t *mnt,
>>>> 	inode_unlock(dentry->d_inode);
>>>>=20
>>>> 	if (IS_ERR(parent)) {
>>>> -		dprintk("%s: get_parent of %ld failed, err %d\n",
>>>> -			__func__, dentry->d_inode->i_ino, PTR_ERR(parent));
>>>> +		dprintk("get_parent of %lu failed, err %ld\n",
>>>> +			dentry->d_inode->i_ino, PTR_ERR(parent));
>>>> 		return parent;
>>>> 	}
>>>>=20
>>>> @@ -147,7 +147,7 @@ static struct dentry *reconnect_one(struct vfsmoun=
t *mnt,
>>>> 	dprintk("%s: found name: %s\n", __func__, nbuf);
>>>> 	tmp =3D lookup_one_unlocked(mnt_user_ns(mnt), nbuf, parent, strlen(nb=
uf));
>>>> 	if (IS_ERR(tmp)) {
>>>> -		dprintk("%s: lookup failed: %d\n", __func__, PTR_ERR(tmp));
>>>> +		dprintk("lookup failed: %ld\n", PTR_ERR(tmp));
>>>> 		err =3D PTR_ERR(tmp);
>>>> 		goto out_err;
>>>> 	}
>>>> --=20
>>>> 2.35.3
>>>>=20
>>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



