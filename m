Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375A93FCB3D
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 18:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhHaQNC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 12:13:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31960 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233018AbhHaQNB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Aug 2021 12:13:01 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VFi4tm004092;
        Tue, 31 Aug 2021 16:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cJMZoAGf1S3GDmSk0tjX8J8YZQN6/pqo54/GnPWL5bE=;
 b=a+MAwvpq0bVWi40qf+vafEQHJdl1bOfBzenn2pZD3Bp3G12wrUnCACUsKZuwaE/yFSaI
 XbIVWXv8fNEqDq2mVCnIyFGp2jK0sEpZze3gHt405B3CI2Mt5kQvsxAVYD1JDNd3e/7y
 VHVC38+XDPXa3gmO3dLozlrG2YTAcArb501Psf7JwtwdDphFJFQvL9ttPS7NIvMo9jYn
 Zp0H1aUlwWrutLJmB/RT1BhCT8sq8uqj0A00edJbSJ1rt7KlVqtOoSFQ2YbGeKZGGe11
 RxDPB9ak85tuxUrcMa683cdM3ioX6/DXViY/fXowM7fBrGeHucLvgudddrWloPt4OM1y 4w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=cJMZoAGf1S3GDmSk0tjX8J8YZQN6/pqo54/GnPWL5bE=;
 b=eAl2UXRiX8T3ackfXqBxc4uuRdSXRxl4ekqBYhfoOSiWgOU+9FCfRTqpSXxvfgBAMaXv
 FFwXY9KJEzBN7l7wQf4yt5aNLWMdGYfSZqwolMEzrZXYXS+kOwx1PsOPLngmN2Z1tmeW
 eNAkL8/dlRuuGoVSsixDdt2tBFdV+H3LEFhZaojwnB43iEwvkOSJo3rBxvlfGwE8JHYC
 EeCFC+zh1QIjvSh2opA/0L30RePaY6TMReklp2+/8qQl3ooTvAeGWYhP+34n5eMxUaRW
 puMy+p4iRBFRu24uFea0EZYvOnJZnAlz0iYKLDugzvrMeNwyv/B517vpaCCf+jlQ7cVc Gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asf66hhjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 16:12:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17VG6HqK186668;
        Tue, 31 Aug 2021 16:11:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3030.oracle.com with ESMTP id 3arpf4nb90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 16:11:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CW/R6nQK5nqC5cWkfP6t9xSmk/+xXRdA8aV5G6+6mZb8q+8/Ptf8oguyL4MFTIsxFc8JxbH30uyB9n2RAtasQUHWK1k5V1Ll1buQZBWmmPFeOTUnQ1Y5HKhdkPPcD1W7uRME+kNCY+madGRcSifGRnlCt3SOXSOm8HKuVrTVDCVbZxyqYup0q4F7prH4g2P6BCHQsoNy5tI6ddHtIBQuXVskh+t9hvgtcwaPO2szF82nGEPzaYQk6OFYoza8dQAA5RyJ85miNtfBRXaiMWkIxgK/HksVQm5rez6F6CTU+umOq+Ti259Av6m/XsTJgmN91Lfl9IrilqL8b95/orrrjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJMZoAGf1S3GDmSk0tjX8J8YZQN6/pqo54/GnPWL5bE=;
 b=TjPT5fxo0zTWR/iJDhonM23xWzn0+tnu3VHRmNhUk8TpCFfOeAA8u9TbyRbuoGodCm+ciSeAa8FnB8IhQ019q2qmxDEA6+q07QS4QAXsi889BK+fHOBZoJYUlWx/Y38Q15PXyog0r+nFiSWurv3SsIl5i/sUMu9Fhp38M8Jubx9JMh4xwgywFI8SJe5LJONm3//YbpQ86HTsOz1LUxjy8AbsnZQ+e94rGwvJ6cwsyF8qLUO7UYnuDXerrxm7MsN+oTMSV2ZP4eZc6nUiNnpROHf6XB5bngTJeN61+lSrMhGvrLSADg1KE0xH0f0JkzvB2LX8grajl/ZgD2RKK4Z0/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJMZoAGf1S3GDmSk0tjX8J8YZQN6/pqo54/GnPWL5bE=;
 b=kR7rzDtvQZ+ZXJHjsKbgZHd8cHbt+tWfqIGEOaTEgnMj3z/76DWKtirqCwkDbNoZqMcGWKgw7lZReLqEEHZ2pAu9DzSFFPdGhR63ApNne0hvqpbG9cYViVQHGvBGdt+MJqC9Ogzi5c92w/+wC5WTxyeNFfL+LJPbhpcoVZllQM8=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3669.namprd10.prod.outlook.com (2603:10b6:a03:119::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 16:11:56 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%7]) with mapi id 15.20.4478.017; Tue, 31 Aug 2021
 16:11:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Thread-Topic: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Thread-Index: AQHXnb+EPQ6bfsCh/km34j6ENph6pKuMRqKAgAAFyYCAAALCgIAAB7UAgAAEWwCAACcYgIABLGAAgAAX/YCAAAOkgA==
Date:   Tue, 31 Aug 2021 16:11:56 +0000
Message-ID: <9B16F1E6-62E1-4A54-930D-7D6B0C2E5857@oracle.com>
References: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
 <20210830165302.60225-2-olga.kornievskaia@gmail.com>
 <F7F9A947-B282-416F-BC65-796BF325054F@oracle.com>
 <CAN-5tyEB9nv576uJijBtyhv2pqAHGNB4yeKo=F21btOkVQuaDQ@mail.gmail.com>
 <04f975f95126921f3d239a7a9d80ced2d88b05ff.camel@hammerspace.com>
 <C73DE4AF-9C1D-4694-839B-D88EABAA6DAC@oracle.com>
 <9448f294a39775734212083cbe329642b9e15d09.camel@hammerspace.com>
 <B5C7A8A1-E810-4616-9E1A-265BADEC5432@oracle.com>
 <AA0A4E98-482C-4276-B8C8-96AF08550320@oracle.com>
 <CAN-5tyGVv1dpoifdaH-R2AdmyfuzFDaBeQEq2gozr1Cd93megQ@mail.gmail.com>
In-Reply-To: <CAN-5tyGVv1dpoifdaH-R2AdmyfuzFDaBeQEq2gozr1Cd93megQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6e91411-73eb-4615-7249-08d96c9a0e0d
x-ms-traffictypediagnostic: BYAPR10MB3669:
x-microsoft-antispam-prvs: <BYAPR10MB366919FF40A012B7D946668A93CC9@BYAPR10MB3669.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YS/HdASIrhBf3mVKI6SvxFePv+8ENEVnHBuPO16doE6gtVQC3YpoeuuBEfKBGSs2gikrOrFzMTqTHlXB8WfqfjhhaDVcMlGjSvH1S7tL/ZkpeC4MJ39vc0fyUo75AZQYx2uGnsiDxW1+oK85aGbVmmiLr5lu+veisWchXZVFg82xtzuMbaJuMf2P2Bbt9CKPOlCYuvsoejEzaTV3nZ2iCoVd9JZjOZW+kwVUIIg8FG7fvq8iKpbINj0zhopkxgXCSFIWb4KGGcyKJYkKW0zUjkigFUV1bcmmb8OokFFvNA13GLHzRCVV47e4fuOTdF27mTudCmSUInqdGz7dQjVuJWa3EKfVICctCFoNVjrvkGqpSv193ENHqK8TBFQxArTBb+P5SxDGwaMM/qB9NaVlFJGv3k9DkvmCL5b/C3kvgZDMZIyIa10Sul6TUwyI94XvJcfZoGlQ4ehzs040+it/FnwRghuklqi/f2g102zFA8NQdjMhye14hrzxKvHLnEh/1WqkW/809Uafscqj/8VfqT+J1vbScOWKj0HKDzaV/4JcmfvCAJQP2d9miAukvNNi0pNsDAuq9eWWTAF0/RfFXUj1Uy4169ntA3A6e8HxUOQzF9u1awDv4fMovwU+pFfTQbsE0ZQhWlqQuYloFMtwIh+fTX+mnrD4SmQx6ZU19pjk8VyT2GPyZf/q3Rf9gXN12up0y4+pzLHMiDSkWJEPm+RWJnnkzcIvAxVAgpZ8ReDyLf/88+dXuQc8c/loPSAc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(346002)(136003)(376002)(6486002)(66476007)(2906002)(4326008)(8676002)(33656002)(38100700002)(86362001)(316002)(8936002)(6506007)(54906003)(5660300002)(122000001)(6916009)(36756003)(66946007)(478600001)(2616005)(91956017)(186003)(66446008)(38070700005)(53546011)(26005)(83380400001)(71200400001)(76116006)(64756008)(6512007)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGozZEdXakVNZHhORVRxcGN4K05veUUwN3M5UkdaMlN5MlNHUHpYWVNPVUFB?=
 =?utf-8?B?QUVmbkwrckhqL2RzcUxDbDQ5SEl5NkJFVG5DZXBUU3NWYlN4QXc2WXNubWo4?=
 =?utf-8?B?K0FTa1dMbk9XTnVaNGoyTW9KbTRqOGJia0NzWXZVS2NrL3lGaW13U0xYalVN?=
 =?utf-8?B?Yk1JaTYrOSs1MGNwSkYxYTUwUndxRGxtNEJTeTlrQlI3Rkw0WW41aGF4N1Js?=
 =?utf-8?B?b0pKdnBhMkpIU1VQSkFsUVh4Z2ZOeXphZmJqR015UWhBU3dpVytNVXE2dlZq?=
 =?utf-8?B?dDF0WE5WakJWZm5ranRvTnczK0lTMUpZSlJjcXFTaFROaEkyd1Z3UXRUVVVN?=
 =?utf-8?B?c0IxVkFuTklPaUlaRXl2eTVDN1NWZkVyNWJybDRkbnFjQVRlR0h5eWF3UGs3?=
 =?utf-8?B?U3FQLzhmNXQ2WHNEZU1BbEFGRFV6MCtSWUJCTUIreUFyTGNHZi9wV0xyODUy?=
 =?utf-8?B?djE4RzRwbHVJZlRTK0JzWTR3Tm45VGkxWVpyY2VTNWlXeTlzdlhzSTMvQVFF?=
 =?utf-8?B?UDFNMUVqSGI1QnQ3Sm9IQzJuc0dwdHlJbEJrckVCNHpsOWhQbC9FY0Yzdjc5?=
 =?utf-8?B?WWVtWndkVnVCMVh2ZEg5UXlwbWwvdWR5TFMwWEZ4d1NiVDBXcnFWVGVya0Iz?=
 =?utf-8?B?THJuUjRQUXVNZlEyVDJYVHBUUXF1VHdIYStBZm9vdkwyZHJYbjNUWG9yVW81?=
 =?utf-8?B?a3A3bCtRcGFLbEptZm1EVHZYMGNtY1h1WjBMQTY3SHBJUmdaVUZsazdhQjN2?=
 =?utf-8?B?aFdUTENnaXhsa2ZLOERmb2pFdk4rVkt1UWxKRk1KZGl4WEJSNnVWS2M4cG5Q?=
 =?utf-8?B?UjFKc1VpQ0hDM2dkQytGN3hJbWU3MjZJU25HMVhmMlZDNGRhbGN0NnozVDRx?=
 =?utf-8?B?MkxwNEZlZGVwQW5QVjFhR1prcExwZTBDUW5rSWJ2T0JTY1dUdEpQQ2FKWFNj?=
 =?utf-8?B?Q0FIRUQ5bDRrdHR1QmFzZWdFVzJjcHJDS0pmMDZmSm1PZE5aOEFmU1RpS0pS?=
 =?utf-8?B?OUJTaGF3MmlZQ0NZQzBaakpvSFhVYXQ5RzlCMjUxUmM0d3MwM2RzT0JQZlEv?=
 =?utf-8?B?d2RJQWl1eThNT1AxalFHa2ROM1RRMGszeHdXZ00vZ1FMNDk4SEtwUFB5SjFV?=
 =?utf-8?B?TkViYkFUeGdVQ0pKdEpLR3diRGVQOTVwOVk0ME1EQjZmdHd4TXQ1RWdmWUJ4?=
 =?utf-8?B?ZTBwQ1FQNnJNR3JLbXJGcXZBR3l1L1orRWJEQjFqdzRWSEdhZ2RFVGRIRzBD?=
 =?utf-8?B?K2s4S0RtU01QSEdKRGlyWkhyZCtWMTgrRjI0aGNoTE5USVVZWXhoazdWbW5z?=
 =?utf-8?B?dHVhcmhSQXNvMERUSE9DV25DTUQwKzNTUFQvNXhaNGJTL2Vta0RubFA4dE0z?=
 =?utf-8?B?WWpwSTIraG4rOEZEaFdnNWorMG14azhmNnFZakRpV0IwaEl0U2JOR3ZhNDhs?=
 =?utf-8?B?KzgrZXBVYWxOYlltS0ZML3J3K2hlbVVoTGtIanIremZqSXl5S2E4cy8ySmVO?=
 =?utf-8?B?Y3pPbFNHR0tvRys2UFlpTldhYWlrOVIrWmZDTGVqYjNKZmtjOU5KU0VYZ25B?=
 =?utf-8?B?OHc3Y2llZ1NkRGdQeDZOZURlWWxEUFA5aVRoaEdaelhJUUsvcHhXQmZEeEJJ?=
 =?utf-8?B?bDVGSG82bi9aK3F2SDFSWHdpWlJFaGVITVp6NUZhdXBDTkFuczhXcW1VOEU5?=
 =?utf-8?B?Q1o4aUp5Q0IrYUoxaEdGVE1XcTlrT1dVWEh5UE4wNE0zemFZOGJxK2k1WFhC?=
 =?utf-8?Q?tbtIj6XC6CqD6saZrFlz/XquSmgGHN5EhcT4Wdy?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BACBBB3C511ED4B8F8DEA8B1EDF40A6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e91411-73eb-4615-7249-08d96c9a0e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 16:11:56.3473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0qHicSsN9jMjBLMKuw/EV+Vixz/j11HK21yS5pDGOwGFoV0sXJtAoKQqFcXrHkwD/p7XojFzZR5mLAeL2cJCpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3669
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310087
X-Proofpoint-GUID: myv4qOOSS3Xpl5NieAk3Oc9kxHO_1zZm
X-Proofpoint-ORIG-GUID: myv4qOOSS3Xpl5NieAk3Oc9kxHO_1zZm
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIEF1ZyAzMSwgMjAyMSwgYXQgMTE6NTggQU0sIE9sZ2EgS29ybmlldnNrYWlhIDxvbGdh
Lmtvcm5pZXZza2FpYUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBBdWcgMzEsIDIw
MjEgYXQgMTA6MzMgQU0gQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3
cm90ZToNCj4+IA0KPj4gU2luY2UgUkZDIDg2NjYgc2F5cyAiU0hPVUxEIE5PVCIsIHRoZSBzcGVj
IG1hbmRhdGVzIHRoYXQgdGhlIGNsaWVudA0KDQpUaGlzIHNob3VsZCBzYXkgIlJGQyA4MTY2LiIN
Cg0KDQo+PiBoYXMgdG8gZXhwZWN0IHRoZXJlIG1pZ2h0IGJlIGEgc2VydmVyIHRoYXQgd2lsbCBS
RE1BIFdyaXRlIHRoZSBYRFINCj4+IHBhZCwgc28gdGhlIExpbnV4IGNsaWVudCByZWFsbHkgc2hv
dWxkIGFsd2F5cyBwcm92aWRlIG9uZS4gSGF2aW5nDQo+PiBhIHBlcnNpc3RlbnRseSByZWdpc3Rl
cmVkIHNwb3QgdG8gdXNlIGZvciB0aGF0IG1lYW5zIHdlIGhhdmUgYQ0KPj4gcG90ZW50aWFsIG5v
LWNvc3QgbWVjaGFuaXNtIGZvciBwcm92aWRpbmcgdGhhdCBleHRyYSBzZWdtZW50LiBUaGUNCj4+
IHdob2xlICJwYWQgb3B0aW1pemF0aW9uIiB0aGluZyB3YXMgYmVjYXVzZSB0aGUgcGFkIHNlZ21l
bnQgaXMNCj4+IGN1cnJlbnRseSByZWdpc3RlcmVkIG9uIHRoZSBmbHksIHNvIGl0IGhhcyBhIHBl
ci1JL08gY29zdC4NCj4gDQo+IEkganVzdCBjYW4ndCByZWNvbmNpbGUgaW4gbXkgaGVhZCB0aGUg
bG9naWMgdGhhdCByZmMgODY2NiAiU0hPVUxEIE5PVCINCj4gYWxsb2NhdGUgYW5kIHJmYyA4MTY2
IHRoYXQgc2F5cyBzZXJ2ZXIgIk1VU1QgTk9UIiB3cml0ZSB0aGUgWERSDQo+IHBhZGRpbmcsIHRv
IG1lYW4gdGhhdCBjbGllbnQgc2hvdWxkIGFsbG9jYXRlIG1lbW9yeS4NCg0KIDMuNC42LjIuICBX
cml0ZSBDaHVuayBSb3VuZHVwDQoNCiAgIFdoZW4gcHJvdmlzaW9uaW5nIGEgV3JpdGUgY2h1bmsg
Zm9yIGEgdmFyaWFibGUtbGVuZ3RoIHJlc3VsdCBkYXRhDQogICBpdGVtLCB0aGUgUmVxdWVzdGVy
IFNIT1VMRCBOT1QgaW5jbHVkZSBhZGRpdGlvbmFsIHNwYWNlIGZvciBYRFINCiAgIHJvdW5kdXAg
cGFkZGluZy4gIEEgUmVzcG9uZGVyIE1VU1QgTk9UIHdyaXRlIFhEUiByb3VuZHVwIHBhZGRpbmcg
aW50bw0KICAgYSBXcml0ZSBjaHVuaywgZXZlbiBpZiB0aGUgUmVxdWVzdGVyIG1hZGUgc3BhY2Ug
YXZhaWxhYmxlIGZvciBpdC4NCiAgIFRoZXJlZm9yZSwgd2hlbiByZXR1cm5pbmcgYSBzaW5nbGUg
dmFyaWFibGUtbGVuZ3RoIHJlc3VsdCBkYXRhIGl0ZW0sDQogICBhIHJldHVybmVkIFdyaXRlIGNo
dW5r4oCZcyB0b3RhbCBsZW5ndGggTVVTVCBiZSB0aGUgc2FtZSBhcyB0aGUgZW5jb2RlZA0KICAg
bGVuZ3RoIG9mIHRoZSByZXN1bHQgZGF0YSBpdGVtLg0KDQpSRkMgODE2Ni1jb21wbGlhbnQgc2Vy
dmVycyBNVVNUIE5PVCB3cml0ZSBwYWRkaW5nLiBwcmUtODE2NiBzZXJ2ZXJzDQpzb21ldGltZXMg
ZG8gd3JpdGUgaXQuIEkgd291bGQgbGlrZSB0aGUgTGludXggY2xpZW50IHRvIGludGVyb3BlcmF0
ZQ0Kd2l0aCBib3RoIGJlY2F1c2Ugbm90IGludGVyb3BlcmF0aW5nIHdpdGggcHJlLTgxNjYgc2Vy
dmVycyB3b3VsZCBiZQ0KYSByZWdyZXNzaW9uLg0KDQoNCj4gSG93IGNhbiB3ZSBhc3Nlc3MgdGhh
dCB0aGVyZSBhcmUgYW55IG9sZCBTb2xhcmlzIHNlcnZlciBvdXQgdGhlcmUgZm9yDQo+IHdoaWNo
IHdlIGFyZSBrZWVwaW5nIHRoaXMgYXJvdW5kPyBBcmUgd2UgZXhwZWN0ZWQgdG8ga2VlcCB0aGlz
DQo+IGZvcmV2ZXI/IFNvcnJ5IHRoZSBhbnN3ZXJzIGFyZSBwcm9iYWJseSBub3Qgd2hhdCBJIHdh
bnQgdG8gaGVhciBhbmQNCj4gSSdtIGp1c3QgbW9yZSBleHByZXNzaW5nIGZydXN0cmF0aW9uLg0K
DQpUaGVyZSdzIG5vIHdheSB0byBrbm93IGhvdyBtYW55IHByZS1SRkMgODE2NiBzZXJ2ZXJzIHRo
ZXJlIGFyZSBvdXQNCnRoZXJlLiBCdXQgdGhhdCdzIG5vdyBtb290LCBzaW5jZSB3ZSBoYXZlIGEg
c29sdXRpb24gdGhhdCBtYWtlcyBpdA0KYmFzaWNhbGx5IGZyZWUgdG8gc3VwcG9ydCB0aGVtLg0K
DQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQoNCg==
